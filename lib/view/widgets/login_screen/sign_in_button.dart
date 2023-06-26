import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_game/view/resources/sizer.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../business_logic/auth_cubit/auth_cubit.dart';
import '../../resources/fonts_manager.dart';
import '../../resources/strings_manager.dart';
import '../sign_up_screen/sign_up_button.dart';

class SignInButton extends StatelessWidget {
  const SignInButton(this.signInKey, {super.key});
  final GlobalKey<FormState> signInKey;
  @override
  Widget build(BuildContext context) {
    final read = context.read<AuthCubit>();
    return SizedBox(
      width: double.infinity,
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (_, current) => authlistener(context, current),
        builder: (context, state) {
          return ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
            onPressed: () async {
              if (signInKey.currentState!.validate()) {
                await read.loginUser();
              } else {
                signInKey.currentState!.validate();
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: state is LoadingState
                  ? const FittedBox(
                      child: CircularProgressIndicator(color: Colors.white))
                  : Text(StringsManager.signIn,
                      style: getRegularTextStyle(
                          fontSize: FontSize.s20, color: Colors.white)),
            ),
          );
        },
      ),
    );
  }
}
