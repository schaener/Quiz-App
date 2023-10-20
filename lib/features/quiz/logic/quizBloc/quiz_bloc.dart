import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:quizapps/features/core/extension.dart';
import 'package:quizapps/features/quiz/logic/timer.dart';

import '../../../core/pair.dart';
import '../../data/models/question_model.dart';
import '../../data/models/result_model.dart';
import '../../data/repositories/quiz_repository.dart';

part 'quiz_bloc.freezed.dart';

part 'quiz_event.dart';

part 'quiz_state.dart';

@injectable
class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository quizRepository;
  final Ticker ticker;

  StreamSubscription<int>? _tickerSubscription;

  QuizBloc({
    required this.quizRepository,
    required this.ticker,
  }) : super(const QuizState()) {
    on<_StartQuizEvent>(_onStartQuiz);
    on<_CheckAnswerEvent>(_onCheckAnswer);
    on<_NextQuestionEvent>(_onNextQuestion);
    on<_ResetQuizEvent>(_onResetQuiz);
    on<_ChangeDurationEvent>(_onChangeDuration);
  }

  final int duration = 30;

  void _onStartQuiz(_StartQuizEvent event, Emitter emit) async {
    _tickerSubscription?.cancel();
    emit(state.copyWith(
      isLoading: true,
    ));
    final result = await () {
      if (event.topicId == null) {
        return quizRepository.getQuestionByRandomTopic();
      }
      return quizRepository.getQuestionByTopic(
        event.topicId ?? emptyString,
      );
    }();
    emit(state.copyWith(
      isLoading: false,
      questions: result,
      currentQuestion:
          result.asRight().isNotEmpty ? result.asRight().first : null,
    ));

    if (result.isRight()) {
      _startTimer();
    }
  }

  void _startTimer() {
    _tickerSubscription?.cancel();
    _tickerSubscription = ticker.tick(ticks: duration).listen((event) {
      if (event <= 0) {
        add(QuizEvent.checkAnswerEvent(
            answer: ResultAnswerModel(
          isCorrect: false,
          answer: emptyString,
          question: state.currentQuestion ?? QuestionModel.empty(),
        )));
      }
      add(QuizEvent.changeDurationEvent(duration: event));
    });
  }

  void _onCheckAnswer(_CheckAnswerEvent event, Emitter emit) async {
    _tickerSubscription?.pause();
    emit(state.copyWith(
      answers: [...?state.answers, event.answer],
      isShowAnswer: true,
    ));
    if (event.answer.isCorrect) {
      emit(state.copyWith(
        totalCorrect: state.totalCorrect + 1,
      ));
    }
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(
      isShowAnswer: false,
    ));
    add(const QuizEvent.nextQuestionEvent());
  }

  void _onNextQuestion(_NextQuestionEvent event, Emitter emit) {
    final indexQuestion = state.indexQuestion + 1;
    if (indexQuestion < (state.questions?.asRight().length ?? 0)) {
      emit(state.copyWith(
        indexQuestion: indexQuestion,
        duration: duration,
        currentQuestion: state.questions?.asRight()[indexQuestion],
      ));
      _startTimer();
    } else {
      emit(state.copyWith(
        indexQuestion: 0,
        duration: duration,
        isShowResult: true,
        currentQuestion: null,
      ));
      _tickerSubscription?.cancel();
    }
  }

  void _onResetQuiz(_ResetQuizEvent event, Emitter emit) {
    emit(const QuizState());
  }

  void _onChangeDuration(_ChangeDurationEvent event, Emitter emit) {
    emit(state.copyWith(
      duration: event.duration,
    ));
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
