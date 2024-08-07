import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newsfeed/firebase_options.dart';
import 'package:newsfeed/pages/login_screen.dart';
import 'package:newsfeed/pages/newsfeed_screen.dart';
import 'package:newsfeed/pages/signup_screen.dart';
import 'package:newsfeed/themes/theme.dart';
import 'package:newsfeed/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context)=>ThemeProvider(),
    child:MyApp()
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return   
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: SignupScreen(),
      routes: {
        '/signup':(context)=> SignupScreen(),
        '/login':(context) =>const  LoginScreen(),
        '/newsfeed':(context) =>const  NewsFeed()
      },
    );
  }
}
