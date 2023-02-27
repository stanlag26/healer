import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:healer/my_widgets/my_text_field.dart';
import '../../api/hive_api/hive_api.dart';
import '../../api/main_navigation/main_navigation.dart';
import '../../api/resource/resource.dart';
import '../../const/const.dart';
import '../../my_widgets/my_button.dart';
import '../../my_widgets/my_toast.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameUser = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  Resource.blank,
                  width: MediaQuery.of(context).size.width / 1.5,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  AppLocalizations.of(context)!.meet,
                  style: MyTextStyle.textStyle25,
                  textAlign: TextAlign.center,
                ),
                MyTextField(
                    hintTextField: AppLocalizations.of(context)!.your_name,
                    controller: nameUser),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                  myText: Text(AppLocalizations.of(context)!.next),
                  onPress: () {
                    if (nameUser.text.isEmpty) {
                      myToast(AppLocalizations.of(context)!.validation);
                    } else {
                      firstEntryInApp(nameUser.text);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        MainNavigationRouteNames.main,
                            (route) => false,
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
