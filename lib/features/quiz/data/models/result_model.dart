import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quizapps/features/quiz/data/models/question_model.dart';

part 'result_model.freezed.dart';

part 'result_model.g.dart';

@freezed
class ResultModel with _$ResultModel {
  const factory ResultModel({
    required String id,
    required String topic,
    required List<ResultAnswerModel> answers,
    @TimestampConverter()
    // ignore: invalid_annotation_target
    @JsonKey(name: 'created_at')
    required DateTime createdAt,
  }) = _ResultModel;

  factory ResultModel.fromJson(Map<String, dynamic> json) =>
      _$ResultModelFromJson(json);
}

@freezed
class ResultAnswerModel with _$ResultAnswerModel {
  const factory ResultAnswerModel({
    required QuestionModel question,
    required String answer,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'is_correct') required bool isCorrect,
  }) = _ResultAnswerModel;

  factory ResultAnswerModel.fromJson(Map<String, dynamic> json) =>
      _$ResultAnswerModelFromJson(json);
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp json) {
    return json.toDate();
  }

  @override
  Timestamp toJson(DateTime object) {
    return Timestamp.fromDate(object);
  }
}
