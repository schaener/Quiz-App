import 'package:freezed_annotation/freezed_annotation.dart';

part 'topic_model.freezed.dart';

part 'topic_model.g.dart';

@freezed
class TopicModel with _$TopicModel {
  const factory TopicModel({
    required String title,
    required String image,
    required String description,
    required String id,
  }) = _TopicModel;

  factory TopicModel.fromJson(Map<String, dynamic> json) =>
      _$TopicModelFromJson(json);
}
