import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class NewsEvent extends Equatable {
  NewsEvent([List props = const []]) : super(props);
}

class FetchNews extends NewsEvent {
  final String query;
  final String from;
  final String sortBy;
  final String apiKey;

  FetchNews({this.query, this.from, this.sortBy, this.apiKey});

  @override
  String toString() {
    return 'FetchNews{query: $query, from: $from, sortBy: $sortBy, apiKey: $apiKey}';
  }
}
