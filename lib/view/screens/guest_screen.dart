import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_game/app/app_router.dart';
import 'package:puzzle_game/view/resources/sizer.dart';

import '../business_logic/game_cubit/game_cubit.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/constants_manager.dart';
import '../resources/fonts_manager.dart';
import '../widgets/home_page/custom_nav_bar.dart';

class GetBackToSignUpButton extends StatelessWidget {
  const GetBackToSignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        'العودة لتسجيل الدخول',
        style: getRegularTextStyle(color: ColorManager.blue),
      ),
      onPressed: () {
        Navigator.pushReplacementNamed(context, RouteNames.signUpRoute);
      },
    );
  }
}

class GuestHomeScreen extends StatelessWidget {
  const GuestHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final read = context.read<GameCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'أهلاً زائر',
          style: getRegularTextStyle(),
          textDirection: TextDirection.rtl,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<GameCubit, GameState>(
        buildWhen: (previous, current) => current is PageChanged,
        builder: (context, state) => GuestPages.pages[read.currentIndex],
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}

class GuestHomeScreenContent extends StatelessWidget {
  const GuestHomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: ConstantsManager.assetsImagesCount + 2,
      itemBuilder: _gridViewBody,
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 50.w,
      ),
    );
  }

  Widget _getCamAndGalleryTile(BuildContext context, int index) {
    final isGallery = index % 2 == 0;
    final text = isGallery ? 'المعرض' : 'الكاميرا';
    final iconData = isGallery ? Icons.image : Icons.camera_alt;
    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text('برجاء تسجيل الدخول للتمتع بتلك الخدمة'),
          actions: [GetBackToSignUpButton()],
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.w),
          color: const Color.fromARGB(255, 243, 243, 243),
          border: Border.all(color: ColorManager.lightGrey, width: 0.4.w),
        ),
        margin: EdgeInsets.all(2.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, size: 24.sp),
            SizedBox(width: 1.w),
            Text(text, style: getRegularTextStyle(fontSize: FontSize.s22)),
          ],
        ),
      ),
    );
  }

  Widget _getImageTile(BuildContext context, int index) {
    index = index - 2;
    String asset = AssetsManager.getAsset(index);

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.preGameRoute,
            arguments: Image.asset(asset));
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.grey,
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(
            image: AssetImage(asset),
            fit: BoxFit.contain,
          ),
        ),
        margin: const EdgeInsets.all(10),
      ),
    );
  }

  Widget _gridViewBody(BuildContext context, int index) {
    if (index < 2) {
      return _getCamAndGalleryTile(context, index);
    } else {
      return _getImageTile(context, index);
    }
  }
}

class GuestPages {
  static List<Widget> pages = [
    const GuestHomeScreenContent(),
    const GuestRankContent()
  ];
}

class GuestRankContent extends StatelessWidget {
  const GuestRankContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: GetBackToSignUpButton());
  }
}
