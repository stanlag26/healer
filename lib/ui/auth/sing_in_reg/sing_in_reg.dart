
import 'package:flutter/material.dart';
import 'package:healer/ui/auth/sing_in_reg/reg_singin_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../api/auth/auth.dart';
import '../../../api/main_navigation/main_navigation.dart';
import '../../../api/my_functions/my_functions.dart';
import '../../../api/resource/resource.dart';
import '../../../const/const.dart';
import '../../../my_widgets/my_button.dart';
import '../../../my_widgets/my_text_field.dart';



class RegisterSingInProviderWidget extends StatelessWidget {
  const RegisterSingInProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => RegisterSingInModel(), child: RegisterSingIn());
  }
}

class RegisterSingIn extends StatelessWidget {
  RegisterSingIn({Key? key}) : super(key: key);

  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<RegisterSingInModel>();
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.welcome,
                  style:MyTextStyle.textStyle25Bolt,
                  textAlign: TextAlign.center,),
                Image.asset(Resource.logoWithoutBackground,
                width: MediaQuery.of(context).size.width/2.5,
                ),
                Text(
                  AppLocalizations.of(context)!.welcome_explanation,
                  style:MyTextStyle.textStyle20Bold,
                  textAlign: TextAlign.center,),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  hintTextField: AppLocalizations.of(context)!.mail,
                  controller: _loginController, mask: false,
                ),
                MyTextField(
                  hintTextField: AppLocalizations.of(context)!.password,
                  controller: _passwordController, mask: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0, top: 5),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, MainNavigationRouteNames.forgotPass);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.forgot_password,
                          ))),
                ),
                model.regOn == false
                    ? MyButton(
                        myText: Text(AppLocalizations.of(context)!.login),
                        onPress: ()  async {
                          await MyAuth.signInWithEmail(context, _loginController.text.trim(), _passwordController.text.trim());
                        })
                    : MyButton(
                        myText: Text(AppLocalizations.of(context)!.registration),
                        onPress: ()  async {
                          await  MyAuth.registerWithEmail(context, _loginController.text.trim(), _passwordController.text.trim());
                        }),
                const SizedBox(
                  height: 5,
                ),
                TextButton(
                    onPressed: () {
                      model.tumbler();
                    },
                    child: Text(
                      model.regOn == false ? AppLocalizations.of(context)!.registration: AppLocalizations.of(context)!.login ,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }


}


