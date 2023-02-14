import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String _userName = 'John Doe';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('User Settings'),
            tiles: [
              SettingsTile(
                title: Text('User Name'),
                leading: Icon(Icons.person),
                onPressed: (BuildContext context) async {
                  final result = await showDialog(
                    context: context,
                    builder: (_) => UserNameDialog(initialValue: _userName),
                  );
                  if (result != null) {
                    setState(() {
                      _userName = result;
                    });
                  }
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text('Account'),
            tiles: [
              SettingsTile(
                title: Text('Exit'),
                leading: Icon(Icons.exit_to_app),
                onPressed: (BuildContext context) {
                  // Perform the action to exit the app
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserNameDialog extends StatefulWidget {
  final String initialValue;

  UserNameDialog({required this.initialValue});

  @override
  _UserNameDialogState createState() => _UserNameDialogState();
}

class _UserNameDialogState extends State<UserNameDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('User Name'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Enter your name',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, _controller.text);
          },
          child: Text('SAVE'),
        ),
      ],
    );
  }
}
