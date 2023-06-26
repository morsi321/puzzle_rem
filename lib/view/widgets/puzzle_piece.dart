import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_game/view/resources/sizer.dart';

import '../../app/app_injection.dart';
import '../business_logic/game_cubit/game_cubit.dart';
import '../resources/constants_manager.dart';
import '../resources/models.dart';
import 'puzzle_piece/puzzle_piece_clipper.dart';
import 'puzzle_piece/puzzle_piece_painter.dart';

class PuzzlePiece extends StatefulWidget {
  final Image image;
  final ArrayIndex index;

  const PuzzlePiece(this.image, this.index, {super.key});

  @override
  PuzzlePieceState createState() => PuzzlePieceState();
}

class PuzzlePieceState extends State<PuzzlePiece> {
  double? top;
  double? left;
  bool isMovable = true;

  @override
  Widget build(BuildContext context) {
    _initializeTopAndLeft();
    return !isMovable
        ? Container()
        : Positioned(
            top: top! + ConstantsManager.topPadding,
            left: left! + ConstantsManager.leftPadding,
            child: SizedBox(
              width: ConstantsManager.imageWidth,
              height: ConstantsManager.imageHeight,
              child: GestureDetector(
                onPanUpdate: (details) {
                  if (isMovable) {
                    setState(() => _updateCurrentPosition(details));
                    _checkRightPlace();
                  }
                },
                child: _getClippedAndPaintedPiece(),
              ),
            ),
          );
  }

  void _initializeTopAndLeft() {
    final read = context.read<GameCubit>();

    final pieceWidth = ConstantsManager.imageWidth / read.piecesSquareLength;
    final pieceHeight = ConstantsManager.imageHeight / read.piecesSquareLength;
    if (top == null) {
      top = Random()
          .nextInt((ConstantsManager.imageHeight - pieceHeight).ceil())
          .toDouble();
      top = top! - widget.index.row * pieceHeight;
    }
    if (left == null) {
      left = Random()
          .nextInt((ConstantsManager.imageWidth - pieceWidth).ceil())
          .toDouble();
      left = left! - widget.index.column * pieceWidth;
    }
  }

  void _updateCurrentPosition(DragUpdateDetails details) {
    final lengthUnit = sL<GameCubit>().piecesSquareLength;
    final lengthUnitIndex = lengthUnit - 1;
    final maxLeft =
        2.6.w + (lengthUnitIndex - widget.index.column) * 94.8.w / lengthUnit;
    final minLeft = -2.6.w - widget.index.column * 94.8.w / lengthUnit;
    final maxTop = 60.h - widget.index.row * 94.8.w / lengthUnit;
    final newTop = top! + details.delta.dy;
    if (newTop < maxTop) top = newTop;
    // top = top! + details.delta.dy;
    // left = left! + details.delta.dx;
    final newLeft = left! + details.delta.dx;
    if (newLeft < maxLeft && newLeft > minLeft) left = newLeft;
  }

  void _checkRightPlace() {
    final read = context.read<GameCubit>();
    final nearToTop = top!.abs() < 10;
    final nearToLeft = left!.abs() < 10;
    if (nearToTop && nearToLeft) {
      _resetPiece();
      read.increaseFixedPieces(widget.index);
    }
  }

  void _resetPiece() {
    top = 0;
    left = 0;
    isMovable = false;
  }

  Widget _getClippedAndPaintedPiece() {
    final read = context.read<GameCubit>();
    final length = read.piecesSquareLength;

    return ClipPath(
      clipper: PuzzlePieceClipper(widget.index, length),
      child: CustomPaint(
        foregroundPainter: PuzzlePiecePainter(widget.index, length),
        child: widget.image,
      ),
    );
  }
}
