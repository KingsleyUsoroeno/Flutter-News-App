import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/data/bloc/news/bloc/news_bloc.dart';
import 'package:flutter_news_app/data/bloc/news/repo/news_repository.dart';
import 'package:flutter_news_app/ui/screens/auth/login_screen.dart';
import 'package:flutter_news_app/ui/screens/auth/sign_up_screen.dart';
import 'package:flutter_news_app/ui/screens/home/home_screen.dart';

import 'file:///C:/Users/user/AndroidStudioProjects/flutter_news_app/lib/ui/screens/news_list/news_list_screen.dart';

import 'data/bloc/auth/auth_bloc.dart';
import 'data/bloc/auth/auth_state.dart';
import 'data/service/authentication_service.dart';
import 'data/service/news_api_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final dio = Dio(); // Provide a Dio instance to the client

  @override
  Widget build(BuildContext context) {
    // Add these if you want the app to check if the user is already authenticated and then do the needful..add(AppStarted()
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (_) => AuthenticationBloc(authenticationService: AuthenticationService(firebaseAuth: FirebaseAuth.instance)),
        ),
        BlocProvider<NewsBloc>(
          create: (_) => NewsBloc(repository: NewsRepository(apiService: NewsApiService(dio))),
        ),
      ],
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
