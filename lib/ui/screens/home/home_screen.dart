import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
                systemNavigationBarColor: Colors.white,
                systemNavigationBarIconBrightness: Brightness.dark),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Welcome to News24.',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0, left: 10.0),
                      child: Text(
                        'Get all your favourite news headlines in one place,',
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Center(
                      child: Text(
                        'all your tools integrated.',
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(height: 50.0),
                    SizedBox(width: 335, height: 290, child: SvgPicture.asset("assets/images/background_image.svg")),
                    SizedBox(height: 30.0),
                    SizedBox(
                      width: 230,
                      height: 50.0,
                      child: MaterialButton(
                        elevation: 6.0,
                        onPressed: () {
                          Navigator.pushNamed(context, "sign_up");
                        },
                        color: Color(0xff44A6FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        child: Text(
                          'sign up',
                          style: TextStyle(color: Colors.white, fontSize: 17.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    SizedBox(
                      width: 230,
                      height: 50.0,
                      child: MaterialButton(
                        elevation: 6.0,
                        onPressed: () {
                          Navigator.pushNamed(context, "login");
                        },
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        child: Text(
                          'sign in',
                          style: TextStyle(color: Color(0xFF1A1A1A), fontSize: 17.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
