import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../../api/internet_connection/internet_connection.dart';
import '../../../api/my_functions/my_functions.dart';
import '../../../const/const.dart';
import '../../../entity/course.dart';
import '../../../my_widgets/my_avatar_photo.dart';
import '../../../my_widgets/my_button.dart';
import '../../../my_widgets/my_text_field.dart';
import '../../../my_widgets/my_toast.dart';
import 'edit_recipes_model.dart';

class EditRecipesProviderWidget extends StatelessWidget {
  const EditRecipesProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Course course = ModalRoute.of(context)!.settings.arguments as Course;
    return ChangeNotifierProvider(
        create: (context) => EditRecipesModel(),
        child: EditRecipes(
          course: course,
        ));
  }
}

class EditRecipes extends StatelessWidget {
  final Course course;
  const EditRecipes({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<EditRecipesModel>();
    model.idDoc = course.idDoc;
    model.namePhotoPillInStorage = course.namePhotoPillInStorage;
    if (model.tumbler == false) {
      model.photoPill = course.photoPill;
      model.namePill = course.namePill;
      model.descriptionPill = course.descriptionPill;
      model.timeOfReceipt = course.timeOfReceipt;
    }
    final TextEditingController namePillController =
        TextEditingController(text: model.namePill);
    final TextEditingController descriptionPillController =
        TextEditingController(text: model.descriptionPill);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            course.namePill,
            style: MyTextStyle.textStyle25,
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  if (await checkInternetConnection() != true) {
                    if (context.mounted) myToast(AppLocalizations.of(context)!.no_internet);
                    return;
                  }
                  if (namePillController.text.isEmpty &&
                      descriptionPillController.text.isEmpty &&
                      model.timeOfReceipt.isEmpty) {
                    if (context.mounted) myToast(AppLocalizations.of(context)!.validation);
                    return;
                  }
                  if (context.mounted)showMyDialogCircular(context);
                  if (context.mounted)await model.editCourseAndToFirebase(context);
                  if (context.mounted) Navigator.of(context, rootNavigator: true).pop();
                  if (context.mounted) Navigator.pop(context);
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
            model.tumbler == false
                ? MyAvatarPhoto(
                    photo: Image.network(course.photoPill, fit: BoxFit.cover))
                : MyAvatarPhoto(
                    photo:
                        Image.file(File(model.photoPill), fit: BoxFit.cover)),
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
                                title: Text(course.timeOfReceipt[index].toString()),
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
