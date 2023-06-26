import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:puzzle_game/view/resources/sizer.dart';

import '../../../app/app_router.dart';
import '../../business_logic/game_cubit/game_cubit.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/constants_manager.dart';
import '../../resources/fonts_manager.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

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

  Future<void> _getImageAndNavigateIfSuccess(
      BuildContext context, ImageSource source) async {
    final read = context.read<GameCubit>();
    final image = await read.getAndCropImage(source);
    if (image != null) {
      //ignore: use_build_context_synchronously
      Navigator.pushNamed(context, RouteNames.preGameRoute, arguments: image);
    }
  }

  Widget _getCamAndGalleryTile(BuildContext context, int index) {
    final isGallery = index % 2 == 0;
    final imageSource = isGallery ? ImageSource.gallery : ImageSource.camera;
    final text = isGallery ? 'المعرض' : 'الكاميرا';
    final iconData = isGallery ? Icons.image : Icons.camera_alt;
    return InkWell(
      onTap: () async =>
          await _getImageAndNavigateIfSuccess(context, imageSource),
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
    String asset = AssetsManager.getAsset(27 - index);

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.preGameRoute,
            arguments: Image.asset(asset));
      },
      child: Container(
        decoration: BoxDecoration(
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
