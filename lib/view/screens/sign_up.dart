import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puzzle_game/app/app_router.dart';
import 'package:puzzle_game/view/resources/assets_manager.dart';
import 'package:puzzle_game/view/resources/sizer.dart';

import '../../app/app_injection.dart';
import '../business_logic/auth_cubit/auth_cubit.dart';
import '../resources/color_manager.dart';
import '../resources/fonts_manager.dart';
import '../widgets/sign_up_screen/sign_up_button.dart';
import '../widgets/sign_up_screen/sign_up_form_content.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpKey = GlobalKey<FormState>();
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: 100.w,
            height: 100.h,
            child: Image.asset(
              AssetsManager.getBackgroundAsset(2),
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.9),
            ),
          ),
          BlocProvider(
            create: (context) => AuthCubit(sL()),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(height: 5.h),
                  Column(
                    children: [
                      Text(
                        'أهلاً بك في لعبة الذاكرة',
                        style: getRegularTextStyle(fontSize: FontSize.s26),
                      ),
                      Text(
                        'أدخل بياناتك للبدء',
                        style: getRegularTextStyle(fontSize: FontSize.s26),
                      ),
                    ],
                  ),
                  SignUpFormContent(signUpKey),
                  SignUpButton(signUpKey),
                  SizedBox(height: 2.h),
                  _getCustomButton(
                    context,
                    text: 'هل لديك حساب بالفعل؟',
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, RouteNames.logInRoute),
                  ),
                  SizedBox(height: 2.h),
                  _getCustomButton(
                    context,
                    text: 'الدخول كضيف',
                    onPressed: () =>
                        Navigator.pushNamed(context, RouteNames.guestHomeRoute),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton _getCustomButton(BuildContext context,
      {required String text, required Function() onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll(ColorManager.white),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            side: const BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(1.w),
          ),
        ),
      ),
      child: Text(text,
          style: getRegularTextStyle(
              fontSize: FontSize.s18, color: ColorManager.blue)),
    );
  }
}
