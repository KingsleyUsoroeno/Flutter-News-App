import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_news_app/data/bloc/news/news.dart';

@immutable
abstract class NewsState extends Equatable {
  NewsState([List props = const []]) : super(props);
}

class NewsInitial extends NewsState {}

class NewsEmpty extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final News news;

  NewsLoaded({this.news});

  @override
  List<Object> get props => [news];
}

class NewsError extends NewsState {
  final String errorMessage;

  NewsError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
