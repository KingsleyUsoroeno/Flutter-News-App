import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/data/bloc/auth/auth_bloc.dart';
import 'package:flutter_news_app/data/bloc/auth/auth_event.dart';
import 'package:flutter_news_app/data/bloc/auth/auth_state.dart';
import 'package:flutter_news_app/data/bloc/auth/model/user.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailEditingController = new TextEditingController();
  final TextEditingController _passwordEditingController = new TextEditingController();

  //  _formKey and _autoValidate
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 30.0, left: 20, right: 20.0),
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 335,
                    height: 290,
                    child: SvgPicture.asset("assets/images/background_image.svg"),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _emailEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email Address', border: OutlineInputBorder()),
                    textInputAction: TextInputAction.next,
                    // ignore: missing_return
                    validator: (String email) {
                      Pattern pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = new RegExp(pattern);
                      if (email.isEmpty) {
                        return "Please enter an email address";
                      } else if (!regex.hasMatch(email)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _passwordEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    // ignore: missing_return
                    validator: (String password) {
                      if (password.isEmpty) {
                        return "Please provide your password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  SizedBox(height: 25.0),
                  BlocConsumer<AuthenticationBloc, AuthenticationState>(
                    bloc: authenticationBloc,
                    listener: (context, state) {
                      if (state is Authenticated) {
                        Navigator.pushReplacementNamed(context, "news_list");
                      } else if (state is Unauthenticated) {
                        // something interrupted the login process or bad credentials were provided
                        print("login error occurred ${state.authenticationError}");
                        final snackBar = SnackBar(content: Text('Failed to login please check your credentials and try again'));
                        // Find the Scaffold in the widget tree and use it to show a SnackBar.
                        Scaffold.of(context).showSnackBar(snackBar);
                      }
                    },
                    builder: (context, state) {
                      if (state is Initial) {
                        return SizedBox(
                          width: 230,
                          height: 50.0,
                          child: MaterialButton(
                            elevation: 4.0,
                            onPressed: () {
                              loginUser(authenticationBloc);
                            },
                            color: Color(0xff44A6FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            child: Text(
                              'Sign in',
                              style: TextStyle(color: Colors.white, fontSize: 17.0),
                            ),
                          ),
                        );
                      }
                      if (state is Loading) {
                        return CircularProgressIndicator();
                      }
                      return Container();
                    },
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account?"),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(context, "sign_up"),
                        child: Text(
                          'Sign up here',
                          style: TextStyle(color: Color(0xff44A6FF)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void loginUser(AuthenticationBloc bloc) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      String email = _emailEditingController.text.toString();
      String password = _passwordEditingController.text.toString();

      bloc.add(LogInEvent(user: User(email: email, password: password)));
    }
  }
}
