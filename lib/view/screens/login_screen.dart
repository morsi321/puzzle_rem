import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puzzle_game/view/business_logic/auth_cubit/auth_cubit.dart';
import 'package:puzzle_game/view/resources/sizer.dart';

import '../../app/app_injection.dart';
import '../resources/assets_manager.dart';
import '../resources/fonts_manager.dart';
import '../widgets/login_screen/log_in_form_content.dart';
import '../widgets/login_screen/sign_in_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginKey = GlobalKey<FormState>();
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
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 3.h),
                    width: 70.w,
                    height: 30.h,
                    child: Image.asset(AssetsManager.logInPic),
                  ),
                  Column(
                    children: [
                      Text(
                        'أهلاً بك في لعبة الذاكرة',
                        style: getRegularTextStyle(fontSize: FontSize.s26),
                      ),
                      Text(
                        'أدخل بياناتك لبدء اللعب',
                        style: getRegularTextStyle(fontSize: FontSize.s20),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  LogInFormContent(loginKey),
                  SignInButton(loginKey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
