import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer_model.freezed.dart';

part 'answer_model.g.dart';

@freezed
class AnswerModel with _$AnswerModel {
  const factory AnswerModel({
    required String text,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'is_correct')
    required bool isCorrect,
  }) = _AnswerModel;

  factory AnswerModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerModelFromJson(json);
}