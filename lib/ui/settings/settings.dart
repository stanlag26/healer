import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../api/auth/auth.dart';
import '../../api/hive_api/hive_api.dart';
import '../../api/main_navigation/main_navigation.dart';
import '../../my_widgets/my_show_dialog.dart';
import 'package:app_settings/app_settings.dart';


class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text(AppLocalizations.of(context)!.name),
            tiles: [
              SettingsTile(
                title: Text(nameUser(),),
                leading: const Icon(Icons.person),
                onPressed: (BuildContext context)  {
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text(AppLocalizations.of(context)!.settings),
            tiles: [
              SettingsTile(
                title: Text(AppLocalizations.of(context)!.settings_push),
                leading: const Icon(Icons.settings),
                onPressed: (BuildContext context)  {
                  AppSettings.openNotificationSettings();
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text(AppLocalizations.of(context)!.account),
            tiles: [
              SettingsTile(
                title: Text(AppLocalizations.of(context)!.exit),
                leading: const Icon(Icons.exit_to_app),
                onPressed: (BuildContext context) {
                  showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return MyShowMyAlertDialog(
                          text: AppLocalizations.of(context)!.logoff,
                          onPressed: () {
                            MyAuth.signOut(context);
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              MainNavigationRouteNames.singIn,
                                  (route) => false,
                            );
                          },
                        );
                      });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

