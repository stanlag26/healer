import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healer/entity/course_hive.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../../api/hive_api/hive_api.dart';
import '../../../api/internet_connection/internet_connection.dart';
import '../../../api/my_functions/my_functions.dart';
import '../../../api/resource/resource.dart';
import '../../../const/const.dart';
import '../../../entity/course.dart';
import '../../../my_widgets/my_avatar_photo.dart';
import '../../../my_widgets/my_button.dart';
import '../../../my_widgets/my_text_field.dart';
import '../../../my_widgets/my_toast.dart';
import 'edit_courses_model.dart';

class EditCoursesProviderWidget extends StatelessWidget {
  const EditCoursesProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = ModalRoute.of(context)!.settings.arguments as List;
    return ChangeNotifierProvider(
        create: (context) => EditCoursesModel(),
        child: EditRecipes(
          list: list,
        ));
  }
}

class EditRecipes extends StatelessWidget {
  final List list;
  const EditRecipes({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<EditCoursesModel>();
    int listIndex = list[0];
    CourseHive courseHive = list[1];
    model.namePill = courseHive.namePill;
    model.photoPill = courseHive.photoPill;
    model.descriptionPill = courseHive.descriptionPill;
    model.timeOfReceipt = courseHive.timeOfReceipt;
    final TextEditingController namePillController =
        TextEditingController(text: model.namePill);
    final TextEditingController descriptionPillController =
        TextEditingController(text: model.descriptionPill);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            model.namePill,
            style: MyTextStyle.textStyle25,
          ),
          actions: [
            IconButton(
                onPressed: ()  {
                  if (namePillController.text.isEmpty &&
                      descriptionPillController.text.isEmpty &&
                      model.timeOfReceipt.isEmpty) {
                     myToast(AppLocalizations.of(context)!.validation);
                    return;
                  }
                  saveEditCourse(
                      listIndex,
                      CourseHive(
                          namePill: model.namePill,
                          descriptionPill: model.descriptionPill,
                          photoPill: model.photoPill,
                          timeOfReceipt: model.timeOfReceipt) );
                 Navigator.pop(context);
                },
                icon: const Icon(
                  FontAwesomeIcons.floppyDisk,
                  size: 25,
                )),
            const SizedBox(
              width: 20,
            )
          ],
          centerTitle: true),
      body: SafeArea(
        child: ListView(
          children: [
            MyTextField(
                onChanged: (value) => model.namePill = value,
                hintTextField: AppLocalizations.of(context)!.namePill,
                controller: namePillController),
            MyTextField(
              onChanged: (value) => model.descriptionPill = value,
              hintTextField: AppLocalizations.of(context)!.descriptionPill,
              controller: descriptionPillController,
              maxLine: 3,
            ),
            const SizedBox(
              height: 15,
            ),
            MyButton(
                myText: Text(AppLocalizations.of(context)!.change_photo),
                onPress: () {
                  model.myShowAdaptiveActionSheet(context);
                }),
            const SizedBox(
              height: 10,
            ),
                MyAvatarPhoto(
                photo: model.photoPill==null
                    ? Image.asset(Resource.pills)
                    :Image.file(File(model.photoPill!), fit: BoxFit.cover)),
            const SizedBox(
              height: 10,
            ),
            MyButton(
                myText: Text(AppLocalizations.of(context)!.add_time_pills),
                onPress: () {
                  model.addTime(context);
                }),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                  itemCount: model.timeOfReceipt.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        elevation: 4.0,
                        child: Column(
                          children: [
                            ListTile(
                                leading: const Icon(FontAwesomeIcons.clock),
                                title: Text(model.timeOfReceipt[index].toString()),
                                trailing: IconButton(
                                  onPressed: () {
                                    model.delTime(index);
                                  },
                                  icon: const Icon(
                                    FontAwesomeIcons.trash,
                                    color: Colors.red,
                                  ),
                                )),
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
