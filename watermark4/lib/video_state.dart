import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoState extends StatefulWidget {
  const VideoState({super.key});

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<VideoState> {
  File? _video; // Variável para armazenar o vídeo selecionado
  VideoPlayerController? _videoController; // Controlador do vídeo
  final double _rotationAngle = -(90 * 3.1416 / 180); // Ângulo de rotação inicial

  // Função para gravar um vídeo
  Future<void> _pickVideo() async {
    final pickedVideo = await ImagePicker().pickVideo(source: ImageSource.camera);

    if (pickedVideo == null) return;

    // Libera o controlador anterior, caso haja
    _videoController?.dispose();

    setState(() {
      _video = File(pickedVideo.path);
      _videoController = VideoPlayerController.file(_video!)
        ..initialize().then((_) {
          setState(() {}); // Atualiza a UI para refletir o estado do vídeo
          _videoController!.play(); // Reproduz o vídeo automaticamente após a inicialização
        });
    });
  }

  // Função para lidar com toques no vídeo
  void _onVideoTapped() {
    setState(() {
      if (_videoController!.value.isPlaying) {
        _videoController!.pause(); // Pausa o vídeo se ele estiver tocando
      } else if (_videoController!.value.position >=
          _videoController!.value.duration) {
        _videoController!.seekTo(Duration.zero); // Reinicia o vídeo se ele tiver terminado
        _videoController!.play(); // Reproduz novamente
      } else {
        _videoController!.play(); // Reproduz o vídeo se estiver pausado
      }
    });
  }

  @override
  void dispose() {
    // Libera os recursos do controlador de vídeo quando não for mais necessário
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // Obtém o tamanho da tela

    return Column(
      children: [
        (_videoController != null || _videoController!.value.isInitialized)
            ? GestureDetector(
          onTap: _onVideoTapped, // Detecta o toque no vídeo
          child: SizedBox(
            height: screenSize.height * 0.4, // 40% da altura da tela
            width: screenSize.width * 0.9, // 90% da largura da tela
            child: Transform.rotate(
              angle: _rotationAngle, // Aplica o ângulo de rotação
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                // Define bordas arredondadas
                child: AspectRatio(
                  aspectRatio: _videoController!.value.aspectRatio,
                  // Usando o aspect ratio original do vídeo
                  child: VideoPlayer(_videoController!),
                ),
              ),
            ),
          ),
        )
            : SizedBox(
          height: screenSize.height * 0.4,
          // Altura reservada caso o vídeo não esteja disponível
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
    );
  }
}
