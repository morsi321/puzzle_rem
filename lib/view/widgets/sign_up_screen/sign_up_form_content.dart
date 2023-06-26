import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_game/view/resources/sizer.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/app_injection.dart';
import '../../business_logic/auth_cubit/auth_cubit.dart';
import '../../business_logic/form_cubit/form_cubit.dart';
import '../../resources/color_manager.dart';
import 'marital_status_drop_button.dart';

class SignUpFormContent extends StatelessWidget {
  const SignUpFormContent(this.signUpKey, {Key? key}) : super(key: key);
  final GlobalKey signUpKey;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Form(
        key: signUpKey,
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final read = context.read<AuthCubit>();

            return Column(
              children: [
                //name
                getPadding(
                  child: TextFormField(
                    decoration: getInputDecoration('الاسم'),
                    onChanged: read.setFullName,
                    validator: sL<FormCubit>().validateField,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                //email
                getPadding(
                  child: TextFormField(
                    decoration: getInputDecoration('الحساب الإليكتروني'),
                    onChanged: read.setEmail,
                    validator: sL<FormCubit>().validateEmail,
                    keyboardType: TextInputType.emailAddress,
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
                    textInputAction: TextInputAction.next,
                  ),
                ),
                //age
                getPadding(
                  child: TextFormField(
                    decoration: getInputDecoration('العمر'),
                    onChanged: read.setAge,
                    keyboardType: TextInputType.number,
                    validator: sL<FormCubit>().validateAge,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                //phone number
                getPadding(
                  child: TextFormField(
                    decoration: getInputDecoration('رقم الجوال'),
                    onChanged: read.setPhone,
                    keyboardType: TextInputType.phone,
                    validator: sL<FormCubit>().validatePhone,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                //country
                getPadding(
                  child: TextFormField(
                    decoration: getInputDecoration('الدولة'),
                    onChanged: read.setCountry,
                    validator: sL<FormCubit>().validateField,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                //city
                getPadding(
                  child: TextFormField(
                    decoration: getInputDecoration('المدينة'),
                    onChanged: read.setCity,
                    validator: sL<FormCubit>().validateField,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                const MaritalStatusDropButton(),
              ],
            );
          },
        ),
      ),
    );
  }
}

InputDecoration getInputDecoration(String hintText) {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: const BorderSide(color: ColorManager.grey, width: 1),
  );
  return InputDecoration(
    enabledBorder: border,
    focusedBorder: border,
    hintText: hintText,
    hintTextDirection: TextDirection.rtl,
    filled: true,
    fillColor: const Color.fromARGB(255, 245, 245, 245),
  );
}

Widget getPadding({required Widget child}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.h),
    child: child,
  );
}
