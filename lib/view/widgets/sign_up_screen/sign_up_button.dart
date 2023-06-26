import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_game/view/resources/sizer.dart';

import '../../../app/app_router.dart';
import '../../business_logic/auth_cubit/auth_cubit.dart';
import '../../resources/color_manager.dart';
import '../../resources/fonts_manager.dart';
import '../../resources/strings_manager.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton(this.signUpKey, {super.key});
  final GlobalKey<FormState> signUpKey;
  @override
  Widget build(BuildContext context) {
    final read = context.read<AuthCubit>();
    return SizedBox(
      width: double.infinity,
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (_, current) => authlistener(context, current),
        builder: (context, state) {
          return ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.blue),
            ),
            onPressed: () async {
              if (signUpKey.currentState!.validate()) {
                await read.registerNewUser();
              } else {
                signUpKey.currentState!.validate();
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: state is LoadingState
                  ? const FittedBox(
                      child: CircularProgressIndicator(color: Colors.white))
                  : Text(
                      StringsManager.register,
                      style: getRegularTextStyle(
                          fontSize: FontSize.s20, color: Colors.white),
                    ),
            ),
          );
        },
      ),
    );
  }
}

authlistener(BuildContext context, AuthState current) {
  if (current is SuccessState) {
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, RouteNames.homeRoute);
  } else if (current is FailureState) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Center(
        child: Text(
          'برحاء إدخال البيانات بشكل صحيح',
          style: getRegularTextStyle(
              fontSize: FontSize.s18, color: ColorManager.white),
        ),
      ),
    );
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
