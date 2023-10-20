import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quizapps/features/core/extension.dart';
import 'package:quizapps/features/core/pair.dart';
import 'package:quizapps/features/quiz/data/models/question_model.dart';
import 'package:quizapps/features/quiz/data/models/result_model.dart';
import 'package:quizapps/features/quiz/data/models/topic_model.dart';

@injectable
class QuizRepository {
  final FirebaseFirestore firestore;

  QuizRepository(
    this.firestore,
  );

  final String _collectionTopic = 'topics';
  final String _collectionQuestion = 'questions';

  Future<Either<Failure, List<TopicModel>>> getTopics() async {
    try {
      final data = await firestore.collection(_collectionTopic).get();
      final result = data.docs.map((e) {
        var data = Map<String, dynamic>.from(e.data());
        data['id'] = e.id;
        return TopicModel.fromJson(data);
      }).toList();
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, TopicModel>> getTopicById(String id) async {
    try {
      final data = await firestore.collection(_collectionTopic).doc(id).get();
      var dataMap = Map<String, dynamic>.from(data.data()!);
      dataMap['id'] = data.id;
      return Right(TopicModel.fromJson(dataMap));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<QuestionModel>>> getQuestionByTopic(
    String topicId, {
    int limit = 5,
  }) async {
    try {
      final data = await firestore
          .collection(_collectionQuestion)
          .where(
            'topic_id',
            isEqualTo: topicId,
          )
          .limit(limit)
          .get();

      final dataTopic = await getTopicById(topicId);
      final result = data.docs.map((e) {
        var data = Map<String, dynamic>.from(e.data());
        data['id'] = e.id;
        final topic = dataTopic.isRight() ? dataTopic.asRight() : null;
        return QuestionModel.fromJson(data).copyWith(
          topic: topic,
        );
      }).toList();
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<QuestionModel>>> getQuestionByRandomTopic({
    int limit = 5,
  }) async {
    try {
      final randomTopic = await getTopics().then((value) {
        if (value.isRight()) {
          final topics = value.asRight();
          var random = (topics.toList()..shuffle()).first;

          return random.id;
        }
        return emptyString;
      });

      final data = await firestore
          .collection(_collectionQuestion)
          .where('topic_id', isEqualTo: randomTopic)
          .limit(limit)
          .get();

      final result = data.docs.map((e) {
        var data = Map<String, dynamic>.from(e.data());

        data['id'] = e.id;
        return QuestionModel.fromJson(data);
      }).toList();
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, ResultModel>> setResultScore(
      ResultModel result) async {
    try {
      await firestore.collection('result_quiz').add(result.toJson());
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
