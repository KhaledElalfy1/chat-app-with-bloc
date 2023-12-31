import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/cubits/register_cubit/register_cubit.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider (
          create: ( context) => LoginCubit(),
        ),
        BlocProvider (
          create: (BuildContext context) => RegisterCubit(),
        ),
        BlocProvider (
          create: (BuildContext context) => ChatCubit(),
        ),
      ],
      child: MaterialApp(
         routes: {
           LoginScreen.id:(context)=>  LoginScreen(),
           RegisterScreen.id:(context)=>  RegisterScreen(),
           ChatScreen.id:(context)=> ChatScreen(),

         },
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.id,
      ),
    );
  }
}
