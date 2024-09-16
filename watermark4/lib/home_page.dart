import 'package:flutter/material.dart';
import 'image_state.dart';
import 'video_state.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Escolha uma marca d'água para seu vídeo"),
              const SizedBox(height: 20),
              ImageState(),
              // Componente que gerencia a seleção de imagem
              const SizedBox(height: 20),
              VideoState(),
              // Componente que gerencia a gravação e reprodução de vídeo
            ],
          ),
        ),
      ),
    );
  }
}
