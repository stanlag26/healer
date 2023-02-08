import 'dart:io';
import 'package:healer/entity/course_hive.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../const/const.dart';
import '../../../my_widgets/my_avatar_photo.dart';



class OneCourse extends StatelessWidget {
  const OneCourse({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    CourseHive courseHive = ModalRoute.of(context)!.settings.arguments as CourseHive;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            courseHive.namePill,
            style: MyTextStyle.textStyle25,
          ),),
      body: SafeArea(
        child: ListView(
          children: [
            Center(child: Text(courseHive.descriptionPill, style: MyTextStyle.textStyle15)),
            const SizedBox(
              height: 15,
            ),
            MyAvatarPhoto(photo:Image.file(File(courseHive.photoPill), fit: BoxFit.cover)),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                  itemCount: courseHive.timeOfReceipt.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        elevation: 4.0,
                        child: Column(
                          children: [
                            ListTile(
                                leading:const Icon(FontAwesomeIcons.clock),
                                title: Text(courseHive.timeOfReceipt[index].toString()),
                            ),
                          ],
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

