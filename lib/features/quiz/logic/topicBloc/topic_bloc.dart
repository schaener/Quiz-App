import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/pair.dart';
import '../../data/models/topic_model.dart';
import '../../data/repositories/quiz_repository.dart';

part 'topic_bloc.freezed.dart';

part 'topic_event.dart';

part 'topic_state.dart';

@injectable
class TopicBloc extends Bloc<TopicEvent, TopicState> {
  final QuizRepository quizRepository;

  TopicBloc({required this.quizRepository}) : super(const TopicState()) {
    on<_GetTopicsEvent>(_onGetTopics);
  }

  void _onGetTopics(TopicEvent event, Emitter emit) async {
    emit(state.copyWith(
      isLoading: true,
    ));
    final result = await quizRepository.getTopics();
    emit(state.copyWith(
      isLoading: false,
      topics: result,
    ));
  }
}
