import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../business_logic/game_cubit/game_cubit.dart';
import '../resources/constants_manager.dart';
import '../resources/models.dart';
import 'puzzle_piece/puzzle_piece_clipper.dart';
import 'puzzle_piece/puzzle_piece_painter.dart';

class FixedPuzzlePiece extends StatelessWidget {
  final Image image;
  final ArrayIndex index;

  const FixedPuzzlePiece(this.image, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    final read = context.read<GameCubit>();

    return BlocBuilder<GameCubit, GameState>(
      buildWhen: (_, current) => current is PuzzlePieceStateChanged,
      builder: (context, state) {
        return !read.fixedPiecesIndexs.contains(read.getIndex(index))
            ? Container()
            : Positioned(
                left: ConstantsManager.leftPadding,
                top: ConstantsManager.topPadding,
                child: SizedBox(
                  width: ConstantsManager.imageWidth,
                  height: ConstantsManager.imageHeight,
                  child: GestureDetector(
                    child: _getClippedAndPaintedPiece(read),
                  ),
                ),
              );
      },
    );
  }

  Widget _getClippedAndPaintedPiece(GameCubit read) {
    final length = read.piecesSquareLength;

    return ClipPath(
      clipper: PuzzlePieceClipper(index, length),
      child: CustomPaint(
        foregroundPainter: PuzzlePiecePainter(index, length),
        child: image,
      ),
    );
  }
}
