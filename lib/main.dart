import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/data/auth/bloc/auth_bloc.dart';
import 'package:flutter_news_app/data/authentication_service.dart';
import 'package:flutter_news_app/ui/screens/auth/login_screen.dart';
import 'package:flutter_news_app/ui/screens/auth/sign_up_screen.dart';
import 'package:flutter_news_app/ui/screens/home/home_screen.dart';
import 'package:flutter_news_app/ui/screens/news_detail/news_list_screen.dart';

import 'data/auth/bloc/auth_event.dart';
import 'data/auth/bloc/auth_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          AuthenticationBloc(authenticationService: AuthenticationService(firebaseAuth: FirebaseAuth.instance))..add(AppStarted()),
      child: MaterialApp(
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
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Initial) {
              return HomeScreen();
            }
            if (state is Authenticated) {
              return NewsListScreen();
            }
            if (state is Unauthenticated) {
              return HomeScreen();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
