import 'dart:io';
import 'package:flutter/material.dart';
import '../../domain/entities/picked_image.dart';

class ImagePreviewPage extends StatelessWidget {
  final PickedImage image;

  const ImagePreviewPage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Preview')),
      body: Center(
        child: Image.file(File(image.path)),
      ),
    );
  }
}