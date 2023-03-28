import 'package:flutter/material.dart';
import 'package:healer/my_widgets/my_button.dart';
import 'dart:io';
import '../../../api/awesome_notifications_push/notifications.dart';
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(list[0], style: MyTextStyle.textStyle25Bold),
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
              child: Text(list[1].toString(),
                  style: MyTextStyle.textStyle20),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child:
              MyAvatarPhoto(
                photo: //Image.asset(Resource.pills, fit: BoxFit.cover),
                list[2] == 'asset://images/pills.jpg'
                    ? Image.asset(Resource.pills, fit: BoxFit.cover)
                    : Image.file(File(list[2].toString().substring(7)),
                        fit: BoxFit.cover)),
              ),
            const SizedBox(
              height: 10,
            ),
            MyButton(
                myText: Text(AppLocalizations.of(context)!.exit),
                onPress: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
