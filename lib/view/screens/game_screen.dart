import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:puzzle_game/view/resources/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/app_injection.dart';
import '../../app/app_router.dart';
import '../../view/resources/strings_manager.dart';
import '../business_logic/game_cubit/game_cubit.dart';
import '../resources/assets_manager.dart';
import '../resources/constants_manager.dart';
import '../resources/fonts_manager.dart';

class GameScreen extends StatefulWidget {
  const GameScreen(this.image, {super.key});
  final Image image;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<GameCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text(StringsManager.appName)),
      body: SafeArea(
        child: BlocListener<GameCubit, GameState>(
          listener: (context, state) {
            if (state is GameFinished) {
              _showToast();
              AudioPlayer().play(AssetSource(AssetsManager.finishGameAudio));
            }
          },
          child: Stack(
            children: [
              SizedBox(height: 100.h, width: 100.w),
              BlocBuilder<GameCubit, GameState>(
                buildWhen: (previous, current) =>
                    current is TimerChanged &&
                    GameCubit.duration.inSeconds <= 60,
                builder: (context, state) {
                  int secondsLeft = (60 - GameCubit.duration.inSeconds);
                  secondsLeft = secondsLeft <= 0 ? 0 : secondsLeft;

                  String convertedSecondsLeft =
                      secondsLeft.toString().padLeft(2, '0');
                  return Positioned(
                    top: 5.h,
                    left: 45.w,
                    child: Text(
                      '00:00:$convertedSecondsLeft',
                      style: getRegularTextStyle(fontSize: FontSize.s22),
                    ),
                  );
                },
              ),
              _getStackBackgroundImage(),
              ...read.backgroundPieces,
              ...read.pieces,
            ],
          ),
          // },
        ),
      ),
    );
  }

  void _showToast() {
    final read = context.read<GameCubit>();

    int seconds = read.endTimerAndReturnDuration();
    GameCubit.duration = const Duration();
    int length = read.piecesSquareLength;
    int pieceCount = pow(length, 2).toInt();
    late int points;
    late String dialogMessage;
    if (seconds > 60) {
      dialogMessage = DialogStrings.lowestAsk(pieceCount);
      points = 10;
    } else {
      Map<int, int> pointSheet = {9: 35, 16: 50, 25: 80};
      points = pointSheet[pieceCount] ?? 10;
      dialogMessage = DialogStrings.lengthPrize(pieceCount, points);
    }

    read.increaseCoins(points);
    final content = SizedBox(
      height: 30.h,
      child: Column(
        children: [
          SizedBox(
            width: 20.h,
            height: 20.h,
            child: Image.asset(AssetsManager.winGif),
          ),
          Text(
            dialogMessage,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.sp),
          ),
        ],
      ),
    );
    showToastWidget(
      content,
      context: context,
      animation: StyledToastAnimation.fadeScale,
      reverseAnimation: StyledToastAnimation.fadeScale,
      duration: const Duration(seconds: 5),
      onDismiss: () {
        int? coins = sL<SharedPreferences>().getInt('coins');
        String route =
            coins == null ? RouteNames.guestHomeRoute : RouteNames.homeRoute;

        Navigator.pushNamedAndRemoveUntil(context, route, (_) => false);
      },
    );
  }

  Widget _getStackBackgroundImage() {
    return Container(
      width: ConstantsManager.imageWidth,
      height: ConstantsManager.imageHeight - ConstantsManager.leftPadding * 2,
      margin: EdgeInsets.only(
        left: ConstantsManager.leftPadding,
        top: ConstantsManager.topPadding + ConstantsManager.leftPadding,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: widget.image.image,
          opacity: 0.3,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  @override
  void initState() {
    context.read<GameCubit>().splitImage(widget.image);

    context.read<GameCubit>().initializeTimer();
    super.initState();
  }

  @override
  void dispose() {
    GameCubit.timer.cancel();
    GameCubit.duration = const Duration();
    super.dispose();
  }
}

class DialogStrings {
  static String lowestAsk(int length) =>
      'مبروك لقد حصلت على 100 نقطة لتجاوزك تحدي ال$length قطع';
  static String lengthPrize(int length, int points) {
    return 'مبروك لقد حصلت على $points نقطة لتجاوزك تحدي ال$length قطع في أقل من ستين ثانية';
  }

  static String threeLengthPrize = lengthPrize(9, 350);
  static String fourLengthPrize = lengthPrize(16, 500);
  static String fiveLengthPrize = lengthPrize(25, 800);
}
