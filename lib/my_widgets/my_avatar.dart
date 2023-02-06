/*
Форма аватара
 */



import 'package:flutter/material.dart';

class MyAvatar extends StatelessWidget {
  final String avatar;
  final String namePill;

  String timeOfReceipt;

  final VoidCallback onPress;
  MyAvatar({
    Key? key,
    required this.avatar, required this.onPress, required this.namePill, this.timeOfReceipt ='',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap:  onPress,
        child: Container(
          margin: const EdgeInsets.only(top: 15, left: 30, right: 30, bottom: 5 ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: 41,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(avatar)),
                ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( namePill, style: const TextStyle(fontSize: 20)),
                    Text( timeOfReceipt, style: const TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
