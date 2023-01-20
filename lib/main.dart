import 'dart:math';

import 'package:flutter/material.dart';
import 'package:me_empresta_ai/screens/login.dart';
import 'package:me_empresta_ai/screens/myFriendListBook.dart';
import 'package:me_empresta_ai/screens/myListBook.dart';
import 'package:me_empresta_ai/screens/homeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Me Empresta Ai',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginWidget(),
        //'/': (context) => const MyBooksWidget()
      },
    );
  }
}
