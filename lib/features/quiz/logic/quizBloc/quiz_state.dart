part of 'quiz_bloc.dart';

@freezed
class QuizState with _$QuizState {
  const factory QuizState({
    Either<Failure, List<QuestionModel>>? questions,
    QuestionModel? currentQuestion,
    @Default(30) int duration,
    List<ResultAnswerModel>? answers,
    @Default(false) bool isShowResult,
    @Default(false) bool isShowAnswer,
    @Default(0) int totalCorrect,
    @Default(0) int indexQuestion,
    @Default(false) bool isLoading,
  }) = _QuizState;
}