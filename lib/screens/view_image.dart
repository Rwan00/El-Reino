import 'package:flutter/material.dart';

class ViewImage extends StatelessWidget {
  final String image;
  const ViewImage({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.1,
          maxScale: 4,
          //constrained: false,
          //boundaryMargin: const EdgeInsets.all(42),
          child: Image.network(
            image,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
