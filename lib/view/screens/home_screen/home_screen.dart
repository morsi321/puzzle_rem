import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puzzle_game/view/business_logic/game_cubit/game_cubit.dart';
import 'package:puzzle_game/view/resources/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/app_injection.dart';
import '../../resources/assets_manager.dart';
import '../../resources/fonts_manager.dart';
import '../../widgets/home_page/custom_nav_bar.dart';
import 'home_content.dart';
import 'rank_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final read = context.read<GameCubit>();
    return Scaffold(
      appBar: getAppBar(),
      body: BlocBuilder<GameCubit, GameState>(
        buildWhen: (previous, current) => current is PageChanged,
        builder: (context, state) => Pages.pages[read.currentIndex],
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }

  AppBar getAppBar() {
    final fullName = sL<SharedPreferences>().getString('fullName')!;
    final coins = sL<SharedPreferences>().getInt('coins')!;
    return AppBar(
      actions: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'أهلاً ${fullName.split(' ')[0]}',
            style: getRegularTextStyle(),
            textDirection: TextDirection.rtl,
          ),
        )
      ],
      centerTitle: false,
      titleTextStyle: getRegularTextStyle(fontSize: FontSize.s20),
      title: Row(
        children: [
          SizedBox(
            height: 8.w,
            width: 8.w,
            child: Image.asset(AssetsManager.goldenCoin, fit: BoxFit.cover),
          ),
          Text(
            coins.toString(),
            style: getRegularTextStyle(fontSize: FontSize.s18),
          ),
        ],
      ),
    );
  }
}

class Pages {
  static List<Widget> pages = [const HomeScreenContent(), const RankContent()];
}
