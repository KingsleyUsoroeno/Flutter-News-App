import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/data/bloc/news/bloc/news_bloc.dart';
import 'package:flutter_news_app/data/bloc/news/bloc/news_event.dart';
import 'package:flutter_news_app/data/bloc/news/bloc/news_state.dart';
import 'package:flutter_news_app/data/bloc/news/news.dart';

class NewsListScreen extends StatefulWidget {
  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsBloc>(context)
      ..add(FetchNews(query: "bitcoin", from: "2020-08-07", sortBy: "publishedAt", apiKey: "ca4ae9f450a44a39bd7b77f9a8745450"));
  }

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
        body: BlocConsumer<NewsBloc, NewsState>(
          listener: (context, state) {
            if (state is NewsLoaded) {
              print("navigate to the news detail screen and pass the news object down ${state.news}");
            }
          },
          builder: (context, state) {
            if (state is NewsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is NewsLoaded) {
              return ListView.builder(
                itemCount: state.news.articles != null ? state.news.articles.length : 0,
                itemBuilder: (context, int index) {
                  final Articles article = state.news.articles[index];
                  return ListTile(
                    contentPadding: EdgeInsets.all(0.0),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        article.urlToImage,
                        height: 150.0,
                        width: 100.0,
                      ),
                    ),
                    title: Text(article.title ?? "Title is not available"),
                    subtitle: Text(article.description ?? "Description is not available"),
                  );
                },
              );
            } else if (state is NewsEmpty) {
              return Container();
            } else
              return Container();
          },
        ),
      ),
    );
  }
}
