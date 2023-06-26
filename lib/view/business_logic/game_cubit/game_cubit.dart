import 'dart:async';
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:puzzle_game/data/repository/web_sevices_repo.dart';
import 'package:puzzle_game/view/business_logic/auth_cubit/auth_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/app_injection.dart';
import '../../../data/model/coins_model.dart';
import '../../resources/models.dart';
import '../../widgets/fixed_puzzle_piece.dart';
import '../../widgets/puzzle_piece.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit(this._webServicesRepo) : super(GameInitial());
  final WebServicesRepo _webServicesRepo;
  int currentIndex = 0;
  List<PuzzlePiece> pieces = [];
  List<FixedPuzzlePiece> backgroundPieces = [];
  List<int> fixedPiecesIndexs = [];
  int piecesSquareLength = 4;

  setCurrentIndex(int newIndex) {
    currentIndex = newIndex;
    emit(PageChanged());
  }

  void increaseCoins(int addedCoins) {
    int? coins = sL<SharedPreferences>().getInt('coins');
    if (coins != null) {
      try {
        _putUpdatedCoins(CoinsModel(addedCoins));
        sL<SharedPreferences>().setInt('coins', coins + addedCoins);
        emit(CoinsAdded());
        // ignore: empty_catches
      } catch (e) {}
    }
  }

  void _putUpdatedCoins(CoinsModel coins) async {
    final String token = getCachedBearerToken();
    await _webServicesRepo.putUpdatedCoins(coins, token);
  }

  Future<File?> _getImageFile(ImageSource source) async {
    XFile? image = await ImagePicker().pickImage(source: source);

    if (image != null) {
      File imageFile = File(image.path);
      return imageFile;
    }
    return null;
  }

  Future<Image?> _cropImageSquare(File file) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.square],
    );
    if (croppedFile != null) {
      return Image.file(File(croppedFile.path));
    } else {
      return null;
    }
  }

  Future<Image?> getAndCropImage(ImageSource source) async {
    final file = await _getImageFile(source);
    if (file != null) {
      final image = await _cropImageSquare(file);

      return image;
    }
    return null;
  }

  void setPiecesSquareLength(int newLength) {
    piecesSquareLength = newLength;
    emit(GameSettingsChanged());
  }

  void splitImage(Image image) {
    resetPieces();
    for (int row = 0; row < piecesSquareLength; row++) {
      for (int col = 0; col < piecesSquareLength; col++) {
        pieces.add(PuzzlePiece(image, ArrayIndex(col, row)));
        backgroundPieces.add(FixedPuzzlePiece(image, ArrayIndex(col, row)));
      }
    }
    emit(GameStart());
  }

  // void bringToTop(PuzzlePiece widget) {
  //   // pieces.remove(widget);
  //   // emit(PuzzlePieceStateChanged());
  //   // pieces.add(widget);
  //   // emit(PuzzlePieceStateChanged());
  //   print(widget.index.column);
  //   print(widget.index.row);
  // }

  // void sendToBack(PuzzlePiece widget) {
  //   pieces.remove(widget);
  //   // emit(PuzzlePieceStateChanged());
  //   pieces.insert(0, widget);
  //   emit(PuzzlePieceStateChanged());
  // }

  void resetPieces() {
    pieces.clear();
    fixedPiecesIndexs = [];
    emit(GameStart());
  }

  void increaseFixedPieces(ArrayIndex arrayIndex) {
    int index = getIndex(arrayIndex);
    fixedPiecesIndexs.add(index);
    emit(PuzzlePieceStateChanged());
    if (fixedPiecesIndexs.length == pieces.length) emit(GameFinished());
  }

  int getIndex(ArrayIndex arrayIndex) {
    return arrayIndex.row * 3 + (arrayIndex.column + 1);
  }

  static Duration duration = const Duration();
  static late Timer timer;
  void _addSec() {
    final seconds = duration.inSeconds;
    duration = Duration(seconds: seconds + 1);
    emit(TimerChanged());
  }

  initializeTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (x) => _addSec());
  }

  int endTimerAndReturnDuration() {
    timer.cancel();
    return duration.inSeconds;
  }
}
