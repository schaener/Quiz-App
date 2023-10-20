part of 'quiz_bloc.dart';

@freezed
class QuizEvent with _$QuizEvent {
  const factory QuizEvent.startQuizEvent({
    required String? topicId,
  }) = _StartQuizEvent;

  const factory QuizEvent.checkAnswerEvent({
    required ResultAnswerModel answer,
  }) = _CheckAnswerEvent;

  const factory QuizEvent.nextQuestionEvent() = _NextQuestionEvent;

  const factory QuizEvent.resetQuizEvent() = _ResetQuizEvent;

  const factory QuizEvent.changeDurationEvent({
    required int duration,
  }) = _ChangeDurationEvent;
}
