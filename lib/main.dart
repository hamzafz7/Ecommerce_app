import 'package:ecommerce_app/ecommerce_app/cubit/shopcubit.dart';
import 'package:ecommerce_app/ecommerce_app/layouts/shoplayout/ShopLayout.dart';
import 'package:ecommerce_app/ecommerce_app/modules/login/login_screen.dart';
import 'package:ecommerce_app/ecommerce_app/styles/themes/themes.dart';
import 'package:ecommerce_app/network/remote/DioHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ecommerce_app/modules/onboarding/Onboarding_screen.dart';

bool? onboarding = false;
bool? islogin = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  SharedPreferences sh = await SharedPreferences.getInstance();
  onboarding = sh.getBool('onboarding') ?? false;
  islogin = sh.getBool('islogin') ?? false;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()
        ..gethomedata()
        ..getCategoriesData()
        ..getFavorites()
        ..getuser(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: lighttheme,
          darkTheme: darktheme,
          home: home()),
    );
  }
}

Widget home() {
  if (onboarding == false && islogin == false)
    return OnboardingScreen();
  else if (onboarding == true && islogin == false)
    return LoginScreen();
  else
    return ShopLayout();
}
