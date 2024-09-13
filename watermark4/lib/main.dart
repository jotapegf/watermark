import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Watermark app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image; // Variável para armazenar a imagem selecionada

  // Função para selecionar uma foto da galeria
  Future _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;
    setState(() {
      _image = File(pickedFile.path);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Escolha uma marca d'água para seu vídeo",
            ),
            const SizedBox(height: 20),
            _image != null
                ? CircleAvatar(
              radius: 40,
              backgroundImage: FileImage(_image!), // Exibe a imagem dentro de um círculo
            )
                : const CircleAvatar(
              radius: 40,
              child: Icon(Icons.add_box),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text("Escolher marca d'água"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Botão de gravar vídeo (sem função)
              },
              child: const Text('Gravar Vídeo'),
            ),
          ],
        ),
      ),
    );
  }
}
