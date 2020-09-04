import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 30.0, left: 20, right: 20.0),
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
                SizedBox(height: 10.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                  textInputAction: TextInputAction.done,
                  // ignore: missing_return
                  validator: (String password) {},
                ),
                SizedBox(height: 10.0),
                SizedBox(height: 25.0),
                SizedBox(
                  width: 230,
                  height: 50.0,
                  child: MaterialButton(
                    elevation: 4.0,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "news_list");
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
    );
  }
}
