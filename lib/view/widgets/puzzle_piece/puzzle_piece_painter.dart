import 'package:flutter/material.dart';
import 'package:puzzle_game/view/resources/color_manager.dart';

import '../../resources/models.dart';
import 'get_piece_path.dart';

class PuzzlePiecePainter extends CustomPainter {
  final ArrayIndex index;
  final int length;

  PuzzlePiecePainter(this.index, this.length);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = ColorManager.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawPath(getPiecePath(size, index, length), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
