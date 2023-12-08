import 'package:ecommerce_training/core/controllers/login_cubit/login_cubit.dart';
import 'package:ecommerce_training/core/controllers/onbording_cubit/onbording_cubit.dart';
import 'package:ecommerce_training/core/controllers/pages_cubit/pages_cubit.dart';
import 'package:ecommerce_training/core/controllers/products_cubit/products_cubit.dart';
import 'package:ecommerce_training/core/controllers/register_cubit/register_cubit.dart';
import 'package:ecommerce_training/core/managers/values.dart';
import 'package:ecommerce_training/core/network/local/cache_helper.dart';
import 'package:ecommerce_training/core/network/remote/dio_helper.dart';
import 'package:ecommerce_training/screens/module/homeScreen.dart';
import 'package:ecommerce_training/screens/module/login_screen.dart';
import 'package:ecommerce_training/screens/module/onbording_screen.dart';
import 'package:ecommerce_training/screens/module/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/managers/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelperStore.init();
  await CacheHelper.init();
  if (CacheHelper.getData(key: 'Boarding') == null) {
    onBoarding = false;
  } else {
    onBoarding = CacheHelper.getData(key: 'Boarding');
  }

  token = CacheHelper.getData(key: 'token');
  natoinalId = CacheHelper.getData(key: 'userId');

  if (onBoarding == false) {
    nextScreen = const OnBoardingScreen();
  } else {
    if (token != null) {
      nextScreen = const HomeScreen();
    } else {
      nextScreen = RegisterScreen();
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnBoardingCubit(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => ProductsCubit()..getHomeProducts(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => PagesCubit(),
          lazy: true,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: nextScreen,
      ),
    );
  }
}
