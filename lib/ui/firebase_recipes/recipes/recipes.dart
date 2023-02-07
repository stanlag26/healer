import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../api/firebase_api/firebase_api.dart';
import '../../../api/hive_api/hive_api.dart';
import '../../../api/internet_connection/internet_connection.dart';
import '../../../api/main_navigation/main_navigation.dart';
import '../../../api/timeofdate/timeofdate.dart';
import '../../../entity/course.dart';
import '../../../api/my_functions/my_functions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            return Container(child: Text('mm'),
            );
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
        onPressed: () {
          Navigator.pushNamed(context, MainNavigationRouteNames.recipesAdd);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
      elevation: 8,
      shadowColor: Colors.black,
      child: ListTile(
          tileColor: Colors.white,
          onTap: () {
            Navigator.pushNamed(context, MainNavigationRouteNames.recipesEdit, arguments: course);
          },
          leading:  IconButton(
              onPressed: () async {
                if (await internetConnection() != true) {
                myToast(AppLocalizations.of(context)!.no_internet);
                return;
                }
                showMyDialogCircular(context);
             await saveCoursesToHive(course);
                Navigator.of(context, rootNavigator: true).pop();
                // if (context.mounted) Navigator.of(context).pop();
                Navigator.popAndPushNamed(context, MainNavigationRouteNames.main);
              },
              icon: const Icon(
                FontAwesomeIcons.plus,
                color: Colors.blue,
              )),
          title: Text(course.namePill),
          subtitle: Text('${AppLocalizations.of(context)!.time_pills} ${listToString(course.timeOfReceipt)}'),
          trailing: IconButton(
              onPressed: () {
                showMyAlertDialogDelRecipes(context, course);
              },
              icon: const Icon(
                FontAwesomeIcons.bucket,
                color: Colors.deepOrange,
              ))),
    );
  }
}
