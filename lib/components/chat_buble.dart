import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';



class ChatBuble extends StatelessWidget {
   const ChatBuble({super.key,required this.message});
   final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.only(left: 16,bottom: 30,top: 30,right: 30),
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),
            )
        ),
        child: Text(message.message,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 20
          ),
        ),
      ),
    );
  }
}

class ChatBubleForAfriend extends StatelessWidget {
  const ChatBubleForAfriend({super.key,required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.only(left: 16,bottom: 30,top: 30,right: 30),
        decoration: const BoxDecoration(
            color: Color(0xff006D84),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            )
        ),
        child: Text(message.message,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 20
          ),
        ),
      ),
    );
  }
}