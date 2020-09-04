import 'package:flutter/material.dart';
import 'package:flutter_news_app/ui/screens/auth/login_screen.dart';
import 'package:flutter_news_app/ui/screens/auth/sign_up_screen.dart';
import 'package:flutter_news_app/ui/screens/home/home_screen.dart';
import 'package:flutter_news_app/ui/screens/news_detail/news_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        "sign_up": (_) => SignUpScreen(),
        "home": (_) => HomeScreen(),
        "login": (_) => LoginScreen(),
        "news_list": (_) => NewsListScreen()
      },
      home: HomeScreen(),
    );
  }
}
