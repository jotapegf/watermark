import 'dart:io';
import 'package:flutter/material.dart';
import 'image_state.dart';
import 'video_state.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _watermarkImage;

  void _updateWatermarkImage(File? image) {
    setState(() {
      _watermarkImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              const Text("Escolha uma marca d'água para seu vídeo"),
              const SizedBox(height: 20),
              ImageState(
                onImageSelected: _updateWatermarkImage,
              ),
              const SizedBox(height: 20),
              VideoState(
                key: const ValueKey('video_state'),
                watermarkImage:
                    _watermarkImage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
