import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/core/utils/bloc_observe.dart';
import 'features/quiz/presentation/screens/home/home_screen.dart';
import 'firebase_options.dart';
import 'injection.dart';

Future<void> main() async {

  if(kDebugMode){
    Bloc.observer = AppBlocObserver();
  }
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App Technical Test',
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          background: const Color(0xFF14294f),
          primary: const Color(0xFF24a8cb),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
