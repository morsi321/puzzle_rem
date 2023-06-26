import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_game/view/business_logic/game_cubit/game_cubit.dart';
import 'package:puzzle_game/view/resources/sizer.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: context.read<GameCubit>().setCurrentIndex,
      currentIndex: context.watch<GameCubit>().currentIndex,
      items: const [
        BottomNavigationBarItem(
          label: 'الصفحة الرئيسية',
          icon: Icon(Icons.home_filled),
        ),
        BottomNavigationBarItem(
          label: 'الترتيب',
          icon: Icon(Icons.check_circle),
        ),
      ],
      selectedFontSize: 13.5.sp,
      unselectedFontSize: 12.sp,
      iconSize: 24.sp,
    );
  }
}
