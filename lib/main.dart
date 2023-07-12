import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
    return MaterialApp(
       routes: {
         LoginScreen.id:(context)=> LoginScreen(),
         RegisterScreen.id:(context)=> RegisterScreen(),
         ChatScreen.id:(context)=> ChatScreen(),

       },
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.id,
    );
  }
}
