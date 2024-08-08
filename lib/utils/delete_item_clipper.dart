import 'package:flutter/material.dart';

class DeleteItemClipper extends CustomClipper<Path> {
  final double progress;

  DeleteItemClipper(this.progress);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * progress, 0);
    path.lineTo(size.width * progress, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
