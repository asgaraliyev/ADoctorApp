import 'package:asgaraliyev/loginworks/signup.dart';
import 'package:flutter/material.dart';
import 'package:asgaraliyev/loginworks/login.dart';
import 'package:asgaraliyev/loading/loading.dart';
import 'package:asgaraliyev/home/home.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'asgaraliyev',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/':(context)=>displaySplash(),
        '/home':(context)=>Home(),
        '/signup':(context)=>SignUp(),
        '/login':(context)=>Login(),
      },
    );
  }
}
