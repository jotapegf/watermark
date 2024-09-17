import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:path_provider/path_provider.dart';
import 'processed_video_screen.dart';

class VideoState extends StatefulWidget {
  final File? watermarkImage;

  const VideoState({super.key, this.watermarkImage});

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<VideoState> {
  File? _video;
  VideoPlayerController? _videoController;
  bool _isProcessing = false;


  Future<void> _pickVideo() async {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.camera, maxDuration: const Duration(seconds: 10),);

    if (pickedVideo == null) {
      return;
    }

    // Libera o controlador anterior, se existir, e aguarda a conclusão
    if (_videoController != null) {
      await _videoController!.pause();
      await _videoController!.dispose();
    }

    setState(() {
      _video = File(pickedVideo.path);
      _videoController = VideoPlayerController.file(_video!)
        ..initialize().then((_) {
          setState(() {});
          _videoController!
              .play();
        });
    });
  }


  void _onVideoTapped() {
    if (_videoController == null || !_videoController!.value.isInitialized) {
      return;
    }

    setState(() {
      if (_videoController!.value.isPlaying) {
        _videoController!.pause();
      } else if (_videoController!.value.position >=
          _videoController!.value.duration) {
        _videoController!
            .seekTo(Duration.zero);
        _videoController!.play();
      } else {
        _videoController!.play();
      }
    });
  }


  Future<void> _addWatermark() async {
    if (_video == null || widget.watermarkImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecione um vídeo e uma marca d'água")),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      // Obtem diretorio temporario para salvar o video processado
      final Directory tempDir = await getTemporaryDirectory();
      final String outputPath =
          '${tempDir.path}/watermarked_${DateTime.now().millisecondsSinceEpoch}.mp4';

      // Comando FFmpeg para redimensionar e adicionar a marca d'agua
      // redimensiona a marca d'agua para 25% da largura do vídeo
      // e a posiciona no canto inferior direito com uma margem de 10 pixels
      String ffmpegCommand = '-i "${_video!.path}" -i "${widget.watermarkImage!.path}" '
          '-filter_complex "[1:v]scale=iw*0.25:-1[wm];[0:v][wm]overlay=W-w-10:H-h-10" '
          '-codec:a copy "$outputPath"';

      print("Executando FFmpeg: $ffmpegCommand");

      final session = await FFmpegKit.execute(ffmpegCommand);
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProcessedVideoScreen(videoPath: outputPath),
          ),
        );
      } else if (ReturnCode.isCancel(returnCode)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Processo cancelado")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erro ao adicionar a marca d'água")),
        );
      }
    } catch (e) {
      print("Erro ao processar vídeo: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro inesperado ao processar o vídeo")),
      );
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }



  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // Obtem o tamanho da tela

    return Stack(
      children: [
        Column(
          children: [
            (_videoController != null && _videoController!.value.isInitialized)
                ? GestureDetector(
                    onTap: _onVideoTapped,
                    child: Stack(
                      children: [
                        SizedBox(
                          height:
                              screenSize.height * 0.4,
                          width:
                              screenSize.width * 0.9,
                          child: RotatedBox(
                            quarterTurns: 3, // Rotaciona -90 graus
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: AspectRatio(
                                aspectRatio:
                                    _videoController!.value.aspectRatio,
                                child: VideoPlayer(_videoController!),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    height: screenSize.height * 0.4,
                    width: screenSize.width * 0.9,
                    child: const Center(
                      child: Text("Nenhum vídeo gravado"),
                    ),
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickVideo,
              child: const Text('Gravar Vídeo'),
            ),
          ],
        ),
        Positioned(
          bottom: 2,
          right: 2,
          child: FloatingActionButton(
            onPressed: (_isProcessing) ? null : _addWatermark,
            tooltip: "Adicionar Marca d'Água",
            child: (_isProcessing)
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : const Icon(Icons.imagesearch_roller_rounded),
          ),
        ),
      ],
    );
  }
}
