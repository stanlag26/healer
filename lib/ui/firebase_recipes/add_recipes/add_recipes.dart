import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healer/api/internet_connection/internet_connection.dart';
import 'package:provider/provider.dart';
import '../../../const/const.dart';
import '../../../my_widgets/my_avatar_photo.dart';
import '../../../my_widgets/my_button.dart';
import '../../../api/my_functions/my_functions.dart';
import '../../../my_widgets/my_text_field.dart';
import '../../../my_widgets/my_toast.dart';
import 'add_recipes_model.dart';
import 'dart:io';

class AddRecipesProviderWidget extends StatelessWidget {
  const AddRecipesProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AddRecipesModel(), child: AddRecipes());
  }
}

class AddRecipes extends StatelessWidget {
  AddRecipes({Key? key}) : super(key: key);

  final TextEditingController namePillController = TextEditingController();
  final TextEditingController descriptionPillController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AddRecipesModel>();
    return Scaffold(
      appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.add_recipe,
            style: MyTextStyle.textStyle25,
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  if (await internetConnection() != true) {
                    myToast(AppLocalizations.of(context)!.no_internet);
                    return;
                  }
                  if (namePillController.text.isEmpty &&
                      descriptionPillController.text.isEmpty &&
                      model.timeOfReceipt.isEmpty) {
                    myToast(AppLocalizations.of(context)!.validation);
                    return;
                  }
                  showMyDialogCircular(context);
                  await model.completeCourseAndToFirebase(context);

                  Navigator.of(context, rootNavigator: true).pop();
                  Navigator.pop(context);
                },
                icon: Icon(
                  FontAwesomeIcons.floppyDisk,
                  size: 25,
                )),
            SizedBox(
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
            SizedBox(
              height: 15,
            ),
            MyButton(
                myText: model.tumbler != true
                    ? Text(AppLocalizations.of(context)!.add_photo)
                    : Text(AppLocalizations.of(context)!.change_photo),
                onPress: () {
                  model.myShowAdaptiveActionSheet(context);
                }),
            SizedBox(
              height: 10,
            ),
            model.tumbler == true
                ? MyAvatarPhoto(
                    photo: Image.file(File(model.photoPill), fit: BoxFit.cover))
                : Container(),
            SizedBox(
              height: 10,
            ),
            MyButton(
                myText: Text(AppLocalizations.of(context)!.add_time_pills),
                onPress: () {
                  model.addTime(context);
                }),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 300,
              child: ListView.builder(
                  itemCount: model.timeOfReceipt.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        elevation: 4.0,
                        child: Column(
                          children: [
                            ListTile(
                                leading: Icon(FontAwesomeIcons.clock),
                                title: Text(model.timeOfReceipt[index]),
                                trailing: IconButton(
                                  onPressed: () {
                                    model.delTime(index);
                                  },
                                  icon: Icon(
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
