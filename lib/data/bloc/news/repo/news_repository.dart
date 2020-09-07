import 'package:flutter_news_app/data/bloc/news/news.dart';
import 'package:flutter_news_app/data/service/news_api_service.dart';

class NewsRepository {
  final NewsApiService apiService;

  NewsRepository({this.apiService});

  Future<News> fetchBitcoinNews({String query, String from, String sortBy, String apiKey}) async {
    final news = await apiService.fetchBitcoinNews(query, from, sortBy, apiKey);
    print("news response is $news");
    return news;
  }
}
