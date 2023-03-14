import 'dart:io';
import 'package:healer/entity/course_hive.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../api/hive_api/hive_api.dart';
import '../../../api/main_navigation/main_navigation.dart';
import '../../../api/my_functions/my_functions.dart';
import '../../../api/resource/resource.dart';
import '../../../api/timeofdate/timeofdate.dart';
import '../../../const/const.dart';
import '../../../my_widgets/my_show_dialog.dart';
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
    return Scaffold(
      body: (model.courses.isEmpty)
          ? SafeArea(
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Image.asset(
                        Resource.myCourse,
                        width: MediaQuery.of(context).size.width / 1.5,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        AppLocalizations.of(context)!.my_course_info,
                        style: MyTextStyle.textStyle20,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: model.courses.length,
              itemBuilder: (BuildContext context, int index) {
                return CardWidget(indexInList: index);
              }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        onPressed: () {
          Navigator.pushNamed(context, MainNavigationRouteNames.coursesAdd);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key, required this.indexInList}) : super(key: key);
  final int indexInList;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CoursesModel>();

    return Card(
      elevation: 8,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)),
      child: ListTile(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
          tileColor: Colors.white,
          onTap: () {
            CourseHive courseHive = model.courses[indexInList];
            Navigator.pushNamed(context, MainNavigationRouteNames.coursesEdit,
                arguments: [indexInList, courseHive]);
          },
          leading: CircleAvatar(
            radius: 26,
            backgroundColor: Colors.black,
            child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                backgroundImage: (model.courses[indexInList].photoPill != null)
                    ? FileImage(File(model.courses[indexInList].photoPill!))
                    : const AssetImage(Resource.pills) as ImageProvider),
          ),
          title: Text(model.courses[indexInList].namePill),
          subtitle: Text(
              '${AppLocalizations.of(context)!.time_pills} ${listToString(model.courses[indexInList].timeOfReceipt)}'),
          trailing: IconButton(
              onPressed: () {
                showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return MyShowMyAlertDialog(
                        text: AppLocalizations.of(context)!.del_recipe,
                        onPressed: () {
                          model.deleteCourse(indexInList);
                          Navigator.of(context).pop();
                        },
                      );
                    });
              },
              icon: const Icon(
                FontAwesomeIcons.bucket,
                color: Colors.blue,
              ))),
    );
  }
}
