import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:quizapps/features/quiz/logic/timer.dart';

import 'firebase_services.dart';

@module
abstract class AppModule {
  @preResolve
  Future<FirebaseService> get fireService => FirebaseService.init();

  @injectable
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  @injectable
  Ticker get ticker => Ticker();
}
