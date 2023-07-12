import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/components/custom_textfiled.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants/constants.dart';
import '../helpers/showsnakbar.dart';

class LoginScreen extends StatefulWidget {
    LoginScreen({super.key});
   static String id='LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   String? email,password;

   GlobalKey<FormState> fromKey = GlobalKey();

   bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall:isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: fromKey,
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
                    Text('LOGIN',
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
                  obscureText: true,
                  onChange: (data){
                  password=data;

                  },
                ),
                const SizedBox(height: 15,),
                CustomButton(text: 'Login',
                  onTap: () async {
                  if (fromKey.currentState!.validate()) {
                    setState(() {
                      isLoading = !isLoading;
                    });
                    try
                      {
                        await userSignin();
                        Navigator.pushNamed(context, ChatScreen.id,arguments: email);
                      }
                    on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        showSnackBar(context,'user not found');
                      } else if (e.code == 'wrong-password') {
                        showSnackBar(context,'wrong password');
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
                    const Text('don\'t have account ?',
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, RegisterScreen.id);
                      },

                      child: const Text('  Sign up',
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
  Future<void> userSignin() async {
     UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email! ,password: password!
                      );
  }
}
