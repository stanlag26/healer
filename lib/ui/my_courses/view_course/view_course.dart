import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healer/my_widgets/my_button.dart';
import 'dart:io';
import '../../../api/main_navigation/main_navigation.dart';
import '../../../api/resource/resource.dart';
import '../../../const/const.dart';
import '../../../my_widgets/my_avatar_photo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ViewCourse extends StatelessWidget {
  const ViewCourse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = ModalRoute.of(context)!.settings.arguments as List;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(list[0], style: MyTextStyle.textStyle25BoldWhite),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 40,right: 30,top: 10,),
                child: Text(list[1].toString(),
                    style: MyTextStyle.textStyle20),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child:
                MyAvatarPhoto(
                  photo: //Image.asset(Resource.pills, fit: BoxFit.cover),
                  list[2] == 'asset://images/pills.jpg'
                      ? Image.asset(Resource.pills, fit: BoxFit.cover)
                      : Image.file(File(list[2].toString().substring(7)),
                          fit: BoxFit.cover)),
                ),
              const SizedBox(
                height: 10,
              ),
              MyButton(
                  myText: Text(AppLocalizations.of(context)!.back),
                  onPress: () {
                 Navigator.pushNamed(context,MainNavigationRouteNames.main);
                  }),
              const SizedBox(
                height: 10,
              ),
          MyButton(
              myText: Text(AppLocalizations.of(context)!.exit),
              onPress: () {
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else if (Platform.isIOS) {
                  exit(0);
                }
              }),
          const SizedBox(
            height: 10,),
              Container(
                margin: EdgeInsets.all(30),

                height: 300,
                color: Colors.cyanAccent,
                child: Center(child: Text('Место для рекламы')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
