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
  late VideoPlayerController
      _processedVideoController; //vai ser inicializada posteriormente (late)

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vídeo com marca d'água!"),
      ),
      body: Center(
        child: _processedVideoController.value.isInitialized
            ? AspectRatio(
                aspectRatio: _processedVideoController.value.aspectRatio,
                child: VideoPlayer(_processedVideoController),
              )
            : const CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_processedVideoController.value.isPlaying) {
              _processedVideoController.pause();
            } else {
              _processedVideoController.play();
            }
          });
        },
        child: Icon(
          _processedVideoController.value.isPlaying
              ? Icons.pause
              : Icons.play_arrow,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
