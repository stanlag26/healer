import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../api/auth/auth.dart';
import '../../api/main_navigation/main_navigation.dart';
import '../../const/const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../my_widgets/my_show_dialog.dart';
import '../firebase_recipes/recipes/recipes.dart';
import '../my_courses/courses/hive_courses.dart';
import 'package:introduction_screen/introduction_screen.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int selectedIndex = 0;

  List<Widget> widgetOptions = <Widget>[
    const CoursesProviderWidget(),
    const Recipes(),
  ];

  void onItemTapped(value) {
    selectedIndex = value;
    setState(() {});
  }

  String? header() {
    final email = FirebaseAuth.instance.currentUser?.email;
    if (email == null) {
      return null;
    }

    return email.substring(0, email.indexOf('@'));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:           IconButton(
          onPressed: () {
            Navigator.pushNamed(
                context, MainNavigationRouteNames.info);
          },
          icon: const Icon(
            FontAwesomeIcons.circleInfo, size: 25,
          ),
        ),
        title: Text(
          header() ?? AppLocalizations.of(context)!.healer,
          style: MyTextStyle.textStyle25,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return MyShowMyAlertDialog(
                        text: AppLocalizations.of(context)!.logoff,
                        onPressed: () {
                          MyAuth.signOut(context);
                          Navigator.popAndPushNamed(
                              context, MainNavigationRouteNames.singIn);
                        },
                      );
                    });
              },
              icon: const Icon(
                FontAwesomeIcons.arrowRightFromBracket,size: 20
              )),
        ],
      ),
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            tooltip: AppLocalizations.of(context)!.my_course_info,
            icon: const Icon(FontAwesomeIcons.pills),
            label: AppLocalizations.of(context)!.my_course,
          ),
          BottomNavigationBarItem(
            tooltip: AppLocalizations.of(context)!.recipe_info,
            icon: const Icon(FontAwesomeIcons.prescriptionBottleMedical),
            label: AppLocalizations.of(context)!.recipe,
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: onItemTapped,
      ),
    );
  }
}
