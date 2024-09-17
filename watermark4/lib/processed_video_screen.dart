import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ProcessedVideoScreen extends StatefulWidget {
  final String videoPath;

  const ProcessedVideoScreen({super.key, required this.videoPath});

  @override
  _ProcessedVideoScreenState createState() => _ProcessedVideoScreenState();
}

class _ProcessedVideoScreenState extends State<ProcessedVideoScreen> {
  late VideoPlayerController _processedVideoController;

  @override
  void initState() {
    super.initState();
    _processedVideoController =
        VideoPlayerController.file(File(widget.videoPath))
          ..initialize().then((_) {
            setState(() {});
            _processedVideoController.play();
          });
  }

  @override
  void dispose() {
    _processedVideoController.dispose();
    super.dispose();
  }

  void _onVideoTapped() {
    setState(() {
      if (_processedVideoController.value.isPlaying) {
        _processedVideoController.pause();
      } else {
        _processedVideoController.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vídeo com marca d'água!"),
      ),
      body: GestureDetector(
        onTap: _onVideoTapped,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Center(
            child: _processedVideoController.value.isInitialized
                ? LayoutBuilder(
                    builder: (context, constraints) {
                      double maxWidth = constraints.maxWidth * 0.95;
                      double maxHeight = constraints.maxHeight * 0.95;
                      double videoAspectRatio =
                          _processedVideoController.value.aspectRatio;

                      double width = maxWidth;
                      double height = width / videoAspectRatio;

                      if (height > maxHeight) {
                        height = maxHeight;
                        width = height * videoAspectRatio;
                      }

                      return ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          width: width,
                          height: height,
                          color:
                              Colors.black,
                          child: VideoPlayer(_processedVideoController),
                        ),
                      );
                    },
                  )
                : const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
