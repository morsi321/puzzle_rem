import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/app_injection.dart';
import '../../../data/model/auth_response.dart';
import '../../../data/model/login_request.dart';
import '../../../data/model/ranked_user.dart';
import '../../../data/model/register_request.dart';
import '../../../data/model/user.dart';
import '../../../data/repository/web_sevices_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._webServicesRepo) : super(AuthInitial());

  final WebServicesRepo _webServicesRepo;

  int maritalStatusValue = 0;

  setmaritalStatusValue(int? value) {
    if (value != null) {
      maritalStatusValue = value;
      emit(AuthDataChanged());
    }
  }

  //register parameters
  String _email = '';
  String _password = '';
  String _country = '';
  String _city = '';
  String _fullName = '';
  String _phone = '';
  String _maritalStatus = '';
  int _age = 0;

  //register setters
  void setEmail(String newValue) => _email = newValue.trim();
  void setPassword(String newValue) => _password = newValue.trim();
  void setCountry(String newValue) => _country = newValue.trim();
  void setCity(String newValue) => _city = newValue.trim();
  void setFullName(String newValue) => _fullName = newValue.trim();
  void setPhone(String newValue) => _phone = newValue.trim();
  void setAge(String newValue) => _age = int.parse(newValue.trim());

  Future<void> _cachUserData(AuthResponse userData) async {
    final prefs = sL<SharedPreferences>();
    await Future.wait([
      prefs.setString('fullName', userData.fullName),
      prefs.setString('id', userData.id),
      prefs.setString('token', userData.token),
      prefs.setInt('coins', userData.coins),
    ]);
  }

  Future<void> registerNewUser() async {
    final maritalValues = ['single', 'married', 'divorced'];
    _maritalStatus = maritalValues[maritalStatusValue];

    final registerRequest = RegisterRequest(
      fullName: _fullName,
      email: _email,
      password: _password,
      age: _age,
      phone: _phone,
      city: _city,
      country: _country,
      maritalStatus: _maritalStatus,
    );
    try {
      emit(LoadingState());
      final userData = await _webServicesRepo.registerNewUser(registerRequest);
      emit(SuccessState());
      await _cachUserData(userData);
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }

  Future<void> loginUser() async {
    final loginRequest = LoginRequest(_email, _password);
    try {
      emit(LoadingState());
      final userData = await _webServicesRepo.loginUser(loginRequest);
      emit(SuccessState());
      await _cachUserData(userData);
    } catch (e) {
      emit(FailureState(e.toString()));
    }
  }

  Future<List<RankedUser>?> getRankedUsers() async {
    String token = getCachedBearerToken();
    List<RankedUser>? rankedUsers;
    try {
      emit(LoadingState());
      rankedUsers = await _webServicesRepo.getRankedUsers(token);
      _cachRankedUsers(rankedUsers);
      emit(SuccessState());
    } catch (e) {
      emit(FailureState(e.toString()));
    }
    return rankedUsers;
  }

  Future<void> _cachRankedUsers(List<RankedUser> rankedUsers) async {
    final prefs = sL<SharedPreferences>();
    List<String> rankedUsersString =
        rankedUsers.map((user) => jsonEncode(user)).toList();
    await prefs.setStringList('rankedUsers', rankedUsersString);
  }

  List<RankedUser>? getCachedRankedUsers() {
    final prefs = sL<SharedPreferences>();
    final rankedUsersString = prefs.getStringList('rankedUsers');
    final rankedUsers = rankedUsersString
        ?.map((string) => RankedUser.fromJson(jsonDecode(string)))
        .toList();
    return rankedUsers;
  }

  //TODO: check availbility of cached token
  Future<User> checkUserAndGetValues() async {
    String cachedToken = getCachedBearerToken();
    User user = await _webServicesRepo.checkUserAndGetValues(cachedToken);
    await _cachUser(user);
    return user;
  }

  Future<void> _cachUser(User user) async {
    final prefs = sL<SharedPreferences>();
    await Future.wait([
      prefs.setString('fullName', user.fullName),
      prefs.setInt('coins', user.coins),
    ]);
  }
}

String getCachedBearerToken() {
  final prefs = sL<SharedPreferences>();
  final cachedToken = prefs.getString('token')!;
  final bearerToken = 'Bearer $cachedToken';
  return bearerToken;
}
