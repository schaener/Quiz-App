import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quizapps/features/quiz/data/models/topic_model.dart';

import '../../../core/extension.dart';
import 'answer_model.dart';

part 'question_model.freezed.dart';

part 'question_model.g.dart';

@freezed
class QuestionModel with _$QuestionModel {
  const factory QuestionModel({
    String? question,
    List<String>? assets,
    List<AnswerModel>? answers,
    String? id,
    TopicModel? topic,
  }) = _QuestionModel;

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  factory QuestionModel.empty() => const QuestionModel(
      question: emptyString,
      assets: [],
      answers: [],
      id: emptyString,
      topic: TopicModel(
        id: emptyString,
        title: emptyString,
        description: emptyString,
        image: emptyString,
      ));
}
