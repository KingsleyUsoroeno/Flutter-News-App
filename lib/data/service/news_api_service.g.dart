// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _NewsApiService implements NewsApiService {
  _NewsApiService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'http://newsapi.org/v2/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  fetchBitcoinNews(query, from, sortBy, apiKey) async {
    ArgumentError.checkNotNull(query, 'query');
    ArgumentError.checkNotNull(from, 'from');
    ArgumentError.checkNotNull(sortBy, 'sortBy');
    ArgumentError.checkNotNull(apiKey, 'apiKey');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      'q': query,
      'from': from,
      'sortBy': sortBy,
      'apiKey': apiKey
    };
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'everything',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = News.fromJson(_result.data);
    return Future.value(value);
  }
}
