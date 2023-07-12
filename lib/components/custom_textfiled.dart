import 'package:flutter/material.dart';

class CustomTextFormFiled extends StatelessWidget {
   CustomTextFormFiled({super.key, this.hintText,this.onChange,this.obscureText=false});
  String? hintText;
  bool? obscureText;
  Function(String)?onChange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data){
        if(data!.isEmpty)
          {
            return 'Field is required';
          }

      },
      obscureText: obscureText!,
      onChanged: onChange,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white
          ) ,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white
          ),
        ),
        hintText: hintText,
        label: Text(hintText!),
      ),
    );
  }
}
