import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageState extends StatefulWidget {
  final Function(File?) onImageSelected;

  const ImageState({super.key, required this.onImageSelected});

  @override
  _ImageState createState() => _ImageState();
}

class _ImageState extends State<ImageState> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    setState(() {
      _image = File(pickedFile.path);
    });

    widget.onImageSelected(_image); // Comunica a imagem selecionada para o pai
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (_image != null)
            ? CircleAvatar(
                radius: 40,
                backgroundImage: FileImage(_image!),
              )
            : GestureDetector(
                onTap: _pickImage,
                child: const CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.add_box),
                ),
              ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _pickImage,
          child: const Text("Escolher marca d'água"),
        ),
      ],
    );
  }
}
