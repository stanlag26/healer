
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healer/api/resource/resource.dart';
import 'package:healer/my_widgets/my_show_dialog.dart';
import 'package:provider/provider.dart';
import '../../../const/const.dart';
import '../../../my_widgets/my_avatar_photo.dart';
import '../../../my_widgets/my_button.dart';
import '../../../api/my_functions/my_functions.dart';
import '../../../my_widgets/my_text_field.dart';
import '../../../my_widgets/my_time_interval.dart';
import '../../../my_widgets/my_toast.dart';
import 'add_courses_model.dart';
import 'dart:io';

class AddCoursesProviderWidget extends StatelessWidget {
  const AddCoursesProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AddCoursesModel(), child: AddCourses());
  }
}

class AddCourses extends StatelessWidget {
  AddCourses({Key? key}) : super(key: key);

  final TextEditingController namePillController = TextEditingController();
  final TextEditingController descriptionPillController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AddCoursesModel>();

    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.add_recipe,
              style: MyTextStyle.textStyle25,
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    if (namePillController.text.isEmpty ||
                        descriptionPillController.text.isEmpty ||
                        model.timeOfReceipt.isEmpty) {
                      myToast(AppLocalizations.of(context)!.validation);
                      return;
                    } else {
                      model.saveNewCoursesToHive();
                    await  showDialog<void>  (
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return MyShowMyAlertDialog(
                              text: AppLocalizations.of(context)!.add_recipe_to_archive,
                              onPressed: () async {
                                if (context.mounted) showMyDialogCircular(context);
                                if (context.mounted)  await model.completeCourseAndToFirebase(context);

                                if (context.mounted) Navigator.of(context, rootNavigator: true).pop();
                                if (context.mounted) Navigator.pop(context);
                              },
                            );
                          });
                      if (context.mounted) Navigator.pop(context);
                      final pickedFile = model.pickedFile;
                      if (pickedFile != null) File(pickedFile.path).delete();
                    }
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
                maxLine: 5,
              ),
              const SizedBox(
                height: 15,
              ),
              MyButton(
                  myText: model.tumbler != true
                      ? Text(AppLocalizations.of(context)!.add_photo)
                      : Text(AppLocalizations.of(context)!.change_photo),
                  onPress: () {
                    model.myShowAdaptiveActionSheet(context);
                  }),
              const SizedBox(
                height: 10,
              ),
              model.tumbler == true
                  ? MyAvatarPhoto(
                      photo: model.photoPill == null
                          ? Image.asset(Resource.pills)
                          : Image.file(File(model.photoPill!), fit: BoxFit.cover))
                  : Container(),
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
                        return MyTimeInterval(
                          count: model.timeOfReceipt.length,
                          titleText: model.timeOfReceipt[index],
                          onPress: () {model.delTime(index);},
                        );
                      })),
            ],
          ),
        ),
      ),
    );
  }
}

