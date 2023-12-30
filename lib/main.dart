import 'package:flutter/material.dart';
import 'package:the_chef/screens/featured_recipes_page.dart';
import 'package:the_chef/screens/home_screen.dart';
import 'package:the_chef/screens/login_screen.dart';

void main() {
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
        'loginScreen': (context) => const LoginScreen(),
        'homeScreen': (context) => const HomeScreen(),
      },
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

