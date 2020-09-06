import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/data/auth/bloc/auth_bloc.dart';
import 'package:flutter_news_app/data/auth/bloc/auth_event.dart';
import 'package:flutter_news_app/data/auth/bloc/auth_state.dart';
import 'package:flutter_news_app/data/auth/bloc/model/user.dart';
import 'package:flutter_svg/svg.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController _emailEditingController = new TextEditingController();
  final TextEditingController _passwordEditingController = new TextEditingController();
  final TextEditingController _confirmPasswordEditingController = new TextEditingController();

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
            padding: EdgeInsets.only(left: 20, right: 20.0),
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
                  SizedBox(height: 15.0),
                  TextFormField(
                    controller: _passwordEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    validator: (String password) {
                      if (password.isEmpty) {
                        return "Please provide your password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    controller: _confirmPasswordEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'Confirm Password', border: OutlineInputBorder()),
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    // ignore: missing_return
                    validator: (String password) {},
                  ),
                  SizedBox(height: 25.0),
                  BlocConsumer<AuthenticationBloc, AuthenticationState>(
                    bloc: authenticationBloc,
                    listener: (BuildContext context, AuthenticationState state) {
                      if (state is Authenticated) {
                        Navigator.pushReplacementNamed(context, "news_list");
                      }
                    },
                    builder: (context, state) {
                      if (state is Initial) {
                        return SizedBox(
                          width: 230,
                          height: 50.0,
                          child: MaterialButton(
                            elevation: 4.0,
                            onPressed: () => _signUp(authenticationBloc),
                            color: Color(0xff44A6FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            child: Text(
                              'Sign up',
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
                  SizedBox(height: 14.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Already have an account?'),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(context, "login"),
                        child: Text(
                          'Sign in here',
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

  void _signUp(AuthenticationBloc bloc) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      String email = _emailEditingController.text.toString();
      String password = _passwordEditingController.text.toString();
      String confirmPassword = _passwordEditingController.text.toString();

      if (password == confirmPassword) {
        print("email is $email and password is $password");
        bloc.add(SignUpEvent(user: User(email: email, password: password)));
      } else {
        print("passwords dont match");
        return;
      }
    }
  }
}
