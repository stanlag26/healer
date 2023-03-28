import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../api/auth/auth.dart';
import '../../api/hive_api/hive_api.dart';
import '../../api/main_navigation/main_navigation.dart';
import '../../const/const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../my_widgets/my_show_dialog.dart';
import '../firebase_recipes/recipes/recipes.dart';
import '../my_courses/courses/hive_courses.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          nameUser(),
          style: MyTextStyle.textStyle25,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, MainNavigationRouteNames.settings);
              },
              icon: const Icon(
                FontAwesomeIcons.gear,size: 20,
              )),
        ],
      ),
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(FontAwesomeIcons.pills),
            label: AppLocalizations.of(context)!.my_course,
          ),
          BottomNavigationBarItem(
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
