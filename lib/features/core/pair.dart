import 'package:equatable/equatable.dart';

import 'extension.dart';

class Pair<T, U> {
  final T first;
  final U second;

  Pair(this.first, this.second);

  @override
  String toString() => 'Pair[$first, $second]';
}

class Failure extends Equatable {
  final String? message;
  const Failure({this.message});
  @override
  List<Object> get props => [message ?? emptyString];
}