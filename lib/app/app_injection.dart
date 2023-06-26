import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:puzzle_game/data/data_source/web_services.dart';
import 'package:puzzle_game/data/repository/web_sevices_repo.dart';
import 'package:puzzle_game/view/business_logic/auth_cubit/auth_cubit.dart';
import 'package:puzzle_game/view/business_logic/game_cubit/game_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/business_logic/form_cubit/form_cubit.dart';

final sL = GetIt.instance;

Future initGetIt() async {
  final prefs = await SharedPreferences.getInstance();
  sL.registerLazySingleton<SharedPreferences>(() => prefs);
  sL.registerLazySingleton<Dio>(() => initDio());
  sL.registerLazySingleton<WebServices>(() => WebServices(sL()));
  sL.registerLazySingleton<WebServicesRepo>(() => WebServicesRepo(sL()));
  sL.registerLazySingleton<AuthCubit>(() => AuthCubit(sL()));
  sL.registerLazySingleton<GameCubit>(() => GameCubit(sL()));
  sL.registerLazySingleton<FormCubit>(() => FormCubit());
}
