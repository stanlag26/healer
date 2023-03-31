import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../api/firebase_api/firebase_api.dart';
import '../../../api/hive_api/hive_api.dart';
import '../../../api/internet_connection/internet_connection.dart';
import '../../../api/main_navigation/main_navigation.dart';
import '../../../api/resource/resource.dart';
import '../../../api/timeofdate/timeofdate.dart';
import '../../../const/const.dart';
import '../../../entity/course.dart';
import '../../../api/my_functions/my_functions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../my_widgets/my_show_dialog.dart';
import '../../../my_widgets/my_toast.dart';

class Recipes extends StatelessWidget {
  const Recipes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Course')
            .where("idUser", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center();
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic>? json = snapshot.data?.docs[index].data();
              Course course = Course.fromJson(json!);
              course.idDoc = snapshot.data!.docs[index].id;
              return CardWidget(course: course);
            },
          );
        },
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required this.course,
  }) : super(key: key);
  final Course course;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      elevation: 8,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (course.photoPill != null)
              ? Image.network(
                  course.photoPill!,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  Resource.pills,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(course.namePill, style: MyTextStyle.textStyle20Bold),
                const SizedBox(height: 5),
                Text(course.descriptionPill, style: MyTextStyle.textStyle15),
                const SizedBox(height: 5),
                Text(
                    '${AppLocalizations.of(context)!.time_medication} ${listToString(course.timeOfReceipt)}',
                    style: MyTextStyle.textStyle15),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (await checkInternetConnection() != true) {
                            if (context.mounted) {
                              myToast(AppLocalizations.of(context)!.no_internet);
                            }
                            return;
                          }
                          if (context.mounted) showMyDialogCircular(context);
                          await saveCoursesToHiveFromFirebase(course);
                          if (context.mounted) {
                            Navigator.of(context, rootNavigator: true).pop();
                          }
                          if (context.mounted) {
                            Navigator.popAndPushNamed(
                                context, MainNavigationRouteNames.main);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: const BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                          ),
                        ),
                        child: Text(AppLocalizations.of(context)!.add_recipe),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog<void>(
                              context: context,
                              barrierDismissible: false, // user must tap button!
                              builder: (BuildContext context) {
                                return MyShowMyAlertDialog(
                                  text: AppLocalizations.of(context)!.del,
                                  onPressed: () {
                                    FireBaseFirestoreApi()
                                        .delCourse(context, course);
                                    Navigator.of(context).pop();
                                  },
                                );
                              });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: const BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                          ),
                        ),
                        child: Text(AppLocalizations.of(context)!.del),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
