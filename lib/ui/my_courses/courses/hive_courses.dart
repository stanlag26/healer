import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:healer/api/awesome_notifications_push/notifications.dart';
import 'package:healer/entity/course_hive.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../api/main_navigation/main_navigation.dart';
import '../../../api/my_functions/my_functions.dart';
import '../../../api/timeofdate/timeofdate.dart';
import '../../../entity/course.dart';
import 'hive_courses_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CoursesProviderWidget extends StatelessWidget {
  const CoursesProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: CoursesModel(), child: const Courses());
  }
}

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  @override
  void initState() {
    super.initState();
    accessToNotifications(context);
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CoursesModel>();
    return ListView.builder(
        itemCount: model.courses.length,
        itemBuilder: (BuildContext context, int index) {
          return CardWidget(indexInList: index);
        });
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key, required this.indexInList}) : super(key: key);
  final int indexInList;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CoursesModel>();

    Future<void> showMyAlertDialogDelHiveCourse()  {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: SingleChildScrollView(
              child: ListBody(
                children: [Text(AppLocalizations.of(context)!.del_recipe)],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  child: Text(AppLocalizations.of(context)!.yes,
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                  onPressed: () {
                    model.deleteCourse(indexInList);
                    Navigator.of(context).pop();
                  }),
              TextButton(
                child: Text(AppLocalizations.of(context)!.no,
                    style: TextStyle(color: Colors.black, fontSize: 15)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }



    return Card(
      elevation: 8,
      shadowColor: Colors.black,
      child: ListTile(
          tileColor: Colors.white,
          onTap: () {
            CourseHive courseHive = model.courses[indexInList];
            Navigator.pushNamed(context, MainNavigationRouteNames.coursesEdit, arguments: courseHive);
          },
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.file(File(model.courses[indexInList].photoPill)),
          ),
          title: Text(model.courses[indexInList].namePill),
          subtitle: Text('${AppLocalizations.of(context)!.time_pills} ${listToString(model.courses[indexInList].timeOfReceipt)}'),
          trailing: IconButton(
              onPressed: () {
                showMyAlertDialogDelHiveCourse();
              },
              icon: const Icon(
                FontAwesomeIcons.bucket,
                color: Colors.deepOrange,
              ))),
    );
  }
}
