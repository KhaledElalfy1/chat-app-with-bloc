import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({required this.text,this.onTap});
  String text;
  VoidCallback?onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
            color: Colors.white
        ),
        alignment: Alignment.center,
        child: Text(text,
          style: const TextStyle(
              fontSize: 20
          ),
        ),

      ),
    );
  }
}
