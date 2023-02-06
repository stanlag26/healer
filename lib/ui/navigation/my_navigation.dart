
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../const/const.dart';
import '../auth/forget_password/forget_password.dart';
import '../auth/sing_in_reg/sing_in_reg.dart';
import '../bottom_navigation_bar/bottom_navigation_bar.dart';
// import 'package:device_preview/device_preview.dart';
import '../firebase_recipes/add_recipes/add_recipes.dart';
import '../firebase_recipes/edit_recipe/edit_recipe.dart';
import '../firebase_recipes/recipes/recipes.dart';
import '../my_courses/courses/hive_courses.dart';
import '../my_courses/one_course/one_course.dart';


class MyNavigation extends StatelessWidget {
  const MyNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        appBarTheme:  AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.white10,
            iconTheme: const IconThemeData(color: Colors.grey, size: 15),
            titleTextStyle: MyTextStyle.textStyle25),),
      debugShowCheckedModeBanner: false,
      title: 'Healer',
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/',
      routes: {
        '/': (context) =>  const MyBottomNavigationBar(),
        '/sign-in': (context) =>  const  RegisterSingInProviderWidget(),
        '/sign-in/forgot': (context) =>  ForgotWidget(),
        '/recipes': (context) =>  const Recipes(),
        '/recipes/add': (context) =>  const AddRecipesProviderWidget(),
        '/recipes/edit': (context) =>  const EditRecipesProviderWidget(),
        '/courses': (context) =>  const CoursesProviderWidget(),
        '/course/edit': (context) =>  const OneCourse(),




      },);
  }


}
