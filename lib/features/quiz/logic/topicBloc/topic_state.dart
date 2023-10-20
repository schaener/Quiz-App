part of 'topic_bloc.dart';

@freezed
class TopicState with _$TopicState {
  const factory TopicState({
    Either<Failure, List<TopicModel>>? topics,
    @Default(false) bool isLoading,
  }) = _TopicState;
}
