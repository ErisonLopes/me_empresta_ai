import 'dart:math';

import 'package:flutter/material.dart';
import 'package:me_empresta_ai/screens/login.dart';
import 'package:me_empresta_ai/screens/myFriendListBook.dart';
import 'package:me_empresta_ai/screens/myListBook.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        // '/': (context) => const LoginWidget(),
        '/': (context) => const MyBooksWidget()
        //'/': (context) => const MyFriendBooksWidget()
      },
    );
  }
}
