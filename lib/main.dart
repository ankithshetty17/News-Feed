import 'package:flutter/material.dart';
import 'package:newsfeed/pages/login_screen.dart';
import 'package:newsfeed/pages/newsfeed_screen.dart';
import 'package:newsfeed/pages/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        brightness: Brightness.light,
        primarySwatch: Colors.lightBlue
      ),
      home:const  SignupScreen(),
      routes: {
        '/signup':(context)=> SignupScreen(),
        '/login':(context) => LoginScreen(),
        '/newsfeed':(context) => NewsFeed()
      },
    );
  }
}
