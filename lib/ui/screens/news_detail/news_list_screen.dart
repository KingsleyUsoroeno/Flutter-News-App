import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Today's News",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 6.0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              contentPadding: EdgeInsets.all(0.0),
              leading: CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.pink,
              ),
              title: Text("Title will come here"),
              subtitle: Text("Description will come here"),
            );
          },
        ),
      ),
    );
  }
}
