import 'package:dio/dio.dart';
import 'package:flutter_news_app/data/bloc/news/news.dart';
import 'package:retrofit/http.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: "http://newsapi.org/v2/")
abstract class NewsApiService {
  factory NewsApiService(Dio dio, {String baseUrl}) = _NewsApiService;

  @GET('everything')
  Future<News> fetchBitcoinNews(
      @Query('q') String query, @Query('from') String from, @Query('sortBy') String sortBy, @Query('apiKey') String apiKey);
}
