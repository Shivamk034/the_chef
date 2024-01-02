import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  signInWithEmail() async{
    if(_emailController.text != "" && _passwordController != "") {
      try{
        // UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
      catch(e) {
        log("Error during sign up: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Email',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const Gap(2),
            TextField(
              // validator: (value) {
              //   if(value == null || value.isEmpty) {
              //     return 'Please enter your name';
              //   }
              //   return null;
              // },
              controller: _emailController,
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: 'Type Your Email',
              ),
              textDirection: TextDirection.ltr,
            ),
            const Gap(6),
            const Text(
              'Password',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const Gap(2),
            TextField(
              // validator: (value) {
              //   if(value == null || value.isEmpty) {
              //     return 'Please enter your email';
              //   }
              //   return null;
              // },
              controller: _passwordController,
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: 'Type Your Password',
              ),
              textDirection: TextDirection.ltr,
            ),
            Gap(10),
            ElevatedButton(
                onPressed: () {
                  signInWithEmailAndPassword();
                },
                child: Text('Login')
            )
          ],
        ),
      )),
    );
  }
}
