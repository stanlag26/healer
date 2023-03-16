import 'package:flutter/material.dart';
import 'package:healer/my_widgets/my_button.dart';
import 'dart:io';
import '../../../api/resource/resource.dart';
import '../../../const/const.dart';
import '../../../entity/course_hive.dart';
import '../../../my_widgets/my_avatar_photo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ViewCourse extends StatelessWidget {
  const ViewCourse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = ModalRoute.of(context)!.settings.arguments as List;
    int listIndex = list[0];
    CourseHive courseHive = list[1];
    return Scaffold(
      appBar: AppBar(
        title: Text(courseHive.namePill, style: MyTextStyle.textStyle25Bold),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Text(courseHive.descriptionPill,
                  style: MyTextStyle.textStyle20),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child:
              MyAvatarPhoto(
                  photo: courseHive.photoPill == null
                      ? Image.asset(Resource.pills, fit: BoxFit.cover)
                      : Image.file(File(courseHive.photoPill!),
                          fit: BoxFit.cover)),
            ),
            const SizedBox(
              height: 10,
            ),
            MyButton(
                myText: Text(AppLocalizations.of(context)!.yes),
                onPress: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
