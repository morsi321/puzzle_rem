import 'package:flutter/material.dart';

import '../../resources/models.dart';
import 'get_piece_path.dart';

class PuzzlePieceClipper extends CustomClipper<Path> {
  final ArrayIndex index;
  final int length;

  PuzzlePieceClipper(this.index, this.length);

  @override
  Path getClip(Size size) => getPiecePath(size, index, length);

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
