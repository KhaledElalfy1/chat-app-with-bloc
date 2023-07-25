import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/components/custom_textfiled.dart';
import 'package:chat_app/cubits/register_cubit/register_cubit.dart';
import 'package:chat_app/cubits/register_cubit/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helpers/showsnakbar.dart';
import 'login_screen.dart';



class RegisterScreen extends StatelessWidget {
  String? email,password;

  GlobalKey<FormState> fromKey = GlobalKey();
  static String id ='RegisterScreen';
  bool isLoading=false;

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit,RegisterState>(
      listener: (context, state) {
        if(state is RegisterLoading)
          {
            isLoading=true;
          }
        else if (state is RegisterSuccess)
          {
            Navigator.pushNamed(context, LoginScreen.id);
            isLoading=false;
          }
        else if (state is RegisterFailure)
          {
            showSnackBar(context, state.errorMessage);
            isLoading=false;
          }
      },
      builder: (context, state) => ModalProgressHUD(
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
                      BlocProvider.of<RegisterCubit>(context).registerUser(
                          email: email!, password: password!);
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
      ),
    );
  }

  Future<void> registerUser() async {
     UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email! ,password: password!
                  );
  }


}
