import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../api/main_navigation/main_navigation.dart';
import '../../const/const.dart';
import '../auth/forget_password/forget_password.dart';
import '../auth/sing_in_reg/sing_in_reg.dart';
import '../bottom_navigation_bar/bottom_navigation_bar.dart';
// import 'package:device_preview/device_preview.dart';
import '../firebase_recipes/recipes/recipes.dart';
import '../intro/info.dart';
import '../my_courses/add_courses/add_courses.dart';
import '../my_courses/courses/hive_courses.dart';
import '../my_courses/edit_courses/edit_courses.dart';
import '../my_courses/view_course/view_course.dart';
import '../settings/settings.dart';

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
        appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.white10,
            iconTheme: IconThemeData(color: Colors.grey, size: 15),
            titleTextStyle: MyTextStyle.textStyle25),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Healer',
      initialRoute:


          FirebaseAuth.instance.currentUser != null ? MainNavigationRouteNames.main : MainNavigationRouteNames.singIn,
      routes: {
        MainNavigationRouteNames.main: (context) => const MyBottomNavigationBar(),
        MainNavigationRouteNames.singIn: (context) => const RegisterSingInProviderWidget(),
        MainNavigationRouteNames.forgotPass: (context) => ForgotWidget(),
        MainNavigationRouteNames.recipes: (context) => const Recipes(),
        MainNavigationRouteNames.courses: (context) => const CoursesProviderWidget(),
        MainNavigationRouteNames.coursesAdd: (context) => const AddCoursesProviderWidget(),
        MainNavigationRouteNames.coursesEdit: (context) => const EditCoursesProviderWidget(),
        MainNavigationRouteNames.coursesView: (context) =>  const ViewCourse(),
        MainNavigationRouteNames.intro: (context) => const Intro(),
        MainNavigationRouteNames.settings: (context) =>  const Settings(),

      },
    );
  }
}
