import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view/business_logic/game_cubit/game_cubit.dart';
import '../view/resources/strings_manager.dart';
import '../view/resources/themes_manager.dart';
import 'app_injection.dart';
import 'app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sL<GameCubit>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: StringsManager.appTitle,
        theme: getLightTheme(),
        initialRoute: AppRouter.getInitialRoute(),
        onGenerateRoute: AppRouter.getRoute,
      ),
    );
  }
}
