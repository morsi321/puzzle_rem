import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puzzle_game/view/business_logic/game_cubit/game_cubit.dart';
import 'package:puzzle_game/view/resources/color_manager.dart';
import 'package:puzzle_game/view/resources/sizer.dart';

import '../../app/app_router.dart';
import '../resources/fonts_manager.dart';
import '../resources/strings_manager.dart';

class PreGameScreen extends StatelessWidget {
  const PreGameScreen(this.image, {super.key});
  final Image image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        StringsManager.appName,
        style: getRegularTextStyle(fontSize: FontSize.s22),
      )),
      body: Column(
        children: [
          Container(
            width: 50.h,
            height: 50.h,
            decoration: BoxDecoration(
              image: DecorationImage(image: image.image, fit: BoxFit.fill),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 1.h),
            child: Text(
              StringsManager.pickLevel,
              style: getRegularTextStyle(fontSize: FontSize.s26),
            ),
          ),
          BlocBuilder<GameCubit, GameState>(
            buildWhen: (_, current) => current is GameSettingsChanged,
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 3; i <= 5; i++) _getPiecesCountTile(context, i)
                ],
              );
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 2.h),
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(1.w),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, RouteNames.gameRoute,
                    arguments: image);
              },
              child: Text(
                StringsManager.start,
                style: getRegularTextStyle(
                    fontSize: FontSize.s26, color: ColorManager.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPiecesCountTile(BuildContext context, int length) {
    final read = context.read<GameCubit>();
    bool isSelected = length == read.piecesSquareLength;
    Color backgroundColor = isSelected ? Colors.blue : ColorManager.lightGrey;
    Color foregroundColor =
        isSelected ? ColorManager.white : ColorManager.black;
    return InkWell(
      onTap: () => read.setPiecesSquareLength(length),
      borderRadius: BorderRadius.circular(5000),
      child: Container(
        width: 15.w,
        height: 15.w,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(5000),
        ),
        alignment: Alignment.center,
        child: Text(
          pow(length, 2).toString(),
          style: getRegularTextStyle(
              fontSize: FontSize.s22, color: foregroundColor),
        ),
      ),
    );
  }
}
