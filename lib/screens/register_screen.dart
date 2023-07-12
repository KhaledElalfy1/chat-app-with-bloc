import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/components/custom_textfiled.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helpers/showsnakbar.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
    const RegisterScreen({super.key});
  static String id ='RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email,password;

  GlobalKey<FormState> fromKey = GlobalKey();

  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall:isLoading ,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key:fromKey ,
            child: ListView(
              children: [
                const SizedBox(height: 75,),
                Image.asset('assets/images/scholar.png',
                  height: 100,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text('scholar chat',
                      style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'Schyler'
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50,),

                const Row(
                  children: [
                    Text('Regist',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                CustomTextFormFiled(hintText: 'Email',
                  onChange: (data){
                  email=data;
                  },
                ),
                const SizedBox(height: 15,),
                CustomTextFormFiled(hintText: 'password',
                  onChange: (data){
                  password=data;
                  },
                ),
                const SizedBox(height: 15,),
                CustomButton(text: 'Sign up',
                  onTap: () async {
                  if (fromKey.currentState!.validate()) {
                    setState(() {
                      isLoading = !isLoading;
                    });
                    try{
                      await registerUser();
                      showSnackBar(context, 'Success');
                      Navigator.pushNamed(context, LoginScreen.id);
                    }
                       on FirebaseAuthException catch(e)
                      {
                      if (e.code == 'weak-password') {
                      showSnackBar(context,'Weak password');
                      } else if (e.code == 'email-already-in-use') {
                        showSnackBar(context,'Email is used');
                      }
                      }
                    setState(() {
                      isLoading = !isLoading;
                    });
                  }



                  },
                ),
                const SizedBox(height: 15,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('already have account ?',
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: const Text('  Login',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xffC7EDE6)
                        ),
                      ),
                    ),

                  ],
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
     UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email! ,password: password!
                  );
  }


}
