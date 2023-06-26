import 'package:flutter_bloc/flutter_bloc.dart';

part 'form_state.dart';

class FormCubit extends Cubit<FormCubitState> {
  FormCubit() : super(FormInitial());

  String? validateEmail(String? email) {
    const msg = 'برجاء إدخال حساب صحيح';
    if (email == null || email == '') return msg;
    final bool isValid = email.length > 8 || email.contains('@');
    return isValid ? null : msg;
  }

  String? validatePassword(String? password) {
    String msg = 'برجاء إدخال كلمة مرور مناسبة';
    if (password == null || password == '') return msg;
    final bool isValid = password.length > 6;
    msg = 'كلمة المرور يجب ألا تقل عن ستة أحرف';
    return isValid ? null : msg;
  }

  String? validateAge(String? age) {
    String msg = 'برجاء إدخال عمرك';
    if (age == null || age == '') return msg;
    msg = 'برجاء إدخال عمرك بشكل صحيح';
    if (int.tryParse(age) == null) return msg;
    final bool isValid = int.parse(age) > 6;
    return isValid ? null : msg;
  }

  String? validatePhone(String? value) {
    String msg = 'برجاء إدخال بياناتك';
    if (value == null || value == '') return msg;
    msg = 'رقم الهاتف يجب أن يكون على الأقل 10 أرقام';
    if (value.length < 10) return msg;
    return null;
  }

  String? validateField(String? value) {
    String msg = 'برجاء إدخال بياناتك';
    if (value == null || value == '') return msg;
    return null;
  }
}
