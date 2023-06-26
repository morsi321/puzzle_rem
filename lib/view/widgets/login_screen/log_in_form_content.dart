import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_game/view/resources/sizer.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/app_injection.dart';
import '../../business_logic/auth_cubit/auth_cubit.dart';
import '../../business_logic/form_cubit/form_cubit.dart';
import '../sign_up_screen/sign_up_form_content.dart';

class LogInFormContent extends StatelessWidget {
  const LogInFormContent(this.signInKey, {Key? key}) : super(key: key);
  final GlobalKey<FormState> signInKey;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Form(
        key: signInKey,
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final read = context.read<AuthCubit>();

            return Column(
              children: [
                //email
                getPadding(
                  child: TextFormField(
                    decoration: getInputDecoration('الحساب الإليكتروني'),
                    onChanged: read.setEmail,
                    validator: sL<FormCubit>().validateEmail,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                //password
                getPadding(
                  child: TextFormField(
                    decoration: getInputDecoration('كلمة السر'),
                    onChanged: read.setPassword,
                    obscureText: true,
                    validator: sL<FormCubit>().validatePassword,
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
