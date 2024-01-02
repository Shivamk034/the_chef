import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_chef/screens/home_screen.dart';
import 'package:the_chef/screens/signUp_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyArTJRzcko1Ge1F-jzB_tbh-1rKcxwOjfg',
        appId: '1:50339887999:android:7270913822f05085d9f84a',
        messagingSenderId: '50339887999',
        projectId: 'recipeapp-d6d00',
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Chef',
      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      routes: {
        'signUpScreen': (context) => const SignUpScreen(),
        'homeScreen': (context) => const HomeScreen(),
      },
      home: const SignUpScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

