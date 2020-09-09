import 'package:flutter/material.dart';
import 'package:flutter_news_app/constants.dart';
import 'package:flutter_news_app/data/bloc/news/news.dart';

class NewsDetailScreen extends StatelessWidget {
  static const routeName = '/news_detail';

  @override
  Widget build(BuildContext context) {
    final Articles articles = ModalRoute.of(context).settings.arguments;
    print("Article passed down is $articles");

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(articles.urlToImage ?? Constants.DEFAULT_IMAGE_URL), fit: BoxFit.cover)),
            ),
            SizedBox(height: 10.0),
            Text(articles.title ?? "Movie title will come here"),
            SizedBox(height: 10.0),
            Text(articles.description ?? "Movie description will come here")
          ],
        ),
      ),
    );
  }
}
