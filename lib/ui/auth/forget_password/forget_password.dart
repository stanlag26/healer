import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../api/auth/auth.dart';
import '../../../my_widgets/my_button.dart';
import '../../../my_widgets/my_text_field.dart';


class ForgotWidget extends StatelessWidget {
  ForgotWidget({Key? key}) : super(key: key);
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white24,
        iconTheme: IconThemeData(
          color: Colors.blue,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(AppLocalizations.of(context)!.password_reset_text,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            MyTextField(
              hintTextField: AppLocalizations.of(context)!.mail,
              controller: _emailController,
              mask: false,
            ),
            const SizedBox(
              height: 10,
            ),
            MyButton(
              myText: Text(AppLocalizations.of(context)!.reset_password),
              onPress: () {
                MyAuth.resetPassword(context, _emailController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
