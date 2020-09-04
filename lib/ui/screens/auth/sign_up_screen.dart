import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20.0),
            height: MediaQuery.of(context).size.height,
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
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Email Address', border: OutlineInputBorder()),
                  textInputAction: TextInputAction.done,
                  // ignore: missing_return
                  validator: (String email) {},
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                  textInputAction: TextInputAction.done,
                  // ignore: missing_return
                  validator: (String password) {},
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Confirm Password', border: OutlineInputBorder()),
                  textInputAction: TextInputAction.done,
                  // ignore: missing_return
                  validator: (String password) {},
                ),
                SizedBox(height: 25.0),
                SizedBox(
                  width: 230,
                  height: 50.0,
                  child: MaterialButton(
                    elevation: 4.0,
                    onPressed: () {},
                    color: Color(0xff44A6FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    child: Text(
                      'Sign up',
                      style: TextStyle(color: Colors.white, fontSize: 17.0),
                    ),
                  ),
                ),
                SizedBox(height: 25.0),
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
    );
  }
}
