import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/constants.dart';
import 'package:flutter_news_app/data/bloc/news/bloc/news_bloc.dart';
import 'package:flutter_news_app/data/bloc/news/bloc/news_event.dart';
import 'package:flutter_news_app/data/bloc/news/bloc/news_state.dart';
import 'package:flutter_news_app/data/bloc/news/news.dart';
import 'package:flutter_news_app/ui/screens/news_detail/news_detail.dart';

class NewsListScreen extends StatefulWidget {
  static const routeName = '/news_list';

  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsBloc>(context)
      ..add(FetchNews(query: "bitcoin", from: "2020-08-11", sortBy: "publishedAt", apiKey: Constants.API_KEY));
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
              return ListView.separated(
                itemCount: state.news.articles != null ? state.news.articles.length : 0,
                itemBuilder: (context, int index) {
                  final Articles article = state.news.articles[index];
                  return ListTile(
                    contentPadding: EdgeInsets.all(0.0),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(article.urlToImage ?? Constants.DEFAULT_IMAGE_URL),
                      radius: 50.0,
                    ),
                    title: Text(article.title ?? "Title is not available"),
                    subtitle: Text(article.description ?? "Description is not available"),
                    onTap: () {
                      Navigator.pushNamed(context, NewsDetailScreen.routeName, arguments: article);
                    },
                  );
                },
                separatorBuilder: (context, int index) {
                  return Divider();
                },
              );
            } else if (state is NewsEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Failed to fetch your news please retry again'),
                    SizedBox(height: 10.0),
                    SizedBox(
                      width: 250,
                      height: 50.0,
                      child: MaterialButton(
                        elevation: 4.0,
                        onPressed: () => {
                          BlocProvider.of<NewsBloc>(context)
                            ..add(FetchNews(query: "bitcoin", from: "2020-08-11", sortBy: "publishedAt", apiKey: Constants.API_KEY))
                        },
                        color: Color(0xff44A6FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                        ),
                        child: Text(
                          'Retry',
                          style: TextStyle(color: Colors.white, fontSize: 17.0),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else
              return Container();
          },
        ),
      ),
    );
  }
}
