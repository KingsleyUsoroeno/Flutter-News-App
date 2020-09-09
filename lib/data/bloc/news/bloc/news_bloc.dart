import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/data/bloc/news/bloc/news_event.dart';
import 'package:flutter_news_app/data/bloc/news/bloc/news_state.dart';
import 'package:flutter_news_app/data/bloc/news/repo/news_repository.dart';
import 'package:meta/meta.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository _newsRepository;

  NewsBloc({@required NewsRepository repository})
      : assert(repository != null),
        _newsRepository = repository;

  @override
  NewsState get initialState => NewsInitial();

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is FetchNews) {
      yield* _mapFetchNewsToState(query: event.query, from: event.from, sortBy: event.sortBy, apiKey: event.apiKey);
    }
  }

  Stream<NewsState> _mapFetchNewsToState({String query, String from, String sortBy, String apiKey}) async* {
    yield NewsLoading();
    try {
      final news = await _newsRepository.fetchBitcoinNews(query: query, from: from, sortBy: sortBy, apiKey: apiKey);
      if (news != null) {
        yield NewsLoaded(news: news);
      } else {
        yield NewsEmpty();
      }
    } catch (e) {
      yield NewsError(e.toString());
      yield NewsEmpty();
    }
  }
}
