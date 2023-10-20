import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:quizapps/features/core/widgets/error.dart';
import 'package:quizapps/features/core/widgets/spacer.dart';
import 'package:quizapps/features/quiz/logic/quizBloc/quiz_bloc.dart';
import 'package:quizapps/features/quiz/logic/topicBloc/topic_bloc.dart';
import 'package:quizapps/features/quiz/presentation/screens/home/home_screen.dart';

import '../../../../core/extension.dart';
import '../../../../core/widgets/text.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
          (route) => false,
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Score'),
          centerTitle: true,
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
        ),
        body: BlocBuilder<QuizBloc, QuizState>(
          bloc: context.read<QuizBloc>(),
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.answers != null) {
              final answers = state.answers;
              final totalQuestion = answers?.length ?? 0;
              final totalCorrect =
                  answers?.where((element) => element.isCorrect).length ?? 0;
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  ResultChart(
                    totalQuestion: totalQuestion,
                    totalCorrect: totalCorrect,
                  ),
                  const VerticalSpacer(val: 20),
                  ElevatedButton(
                    onPressed: () {
                      Share.share(
                        'I got $totalCorrect correct answers from $totalQuestion questions'
                        '\n\n'
                        'in Flutter Quiz App'
                        '\n\n'
                        'Download now on Google Play Store',
                      );
                    },
                    child: const Text('Share your score'),
                  ),
                  const VerticalSpacer(),
                  const TitleText(
                    'Your Report',
                  ),
                  const VerticalSpacer(),
                  ...?answers?.map((e) {
                    return ListTile(
                      title: ButtonText(e.question.question ?? emptyString),
                      subtitle: LabelText(e.answer),
                      trailing: e.isCorrect
                          ? const Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                    );
                  }),
                ],
              );
            }

            return ErrorContainer(
              onRetry: () {
                context.read<TopicBloc>().add(
                      const TopicEvent.getTopicsEvent(),
                    );
              },
            );
          },
        ),
      ),
    );
  }
}

class ResultChart extends StatelessWidget {
  final int totalQuestion;
  final int totalCorrect;

  const ResultChart({
    super.key,
    required this.totalQuestion,
    required this.totalCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 150,
          width: 150,
          child: CircularProgressIndicator(
            value: totalCorrect / totalQuestion,
            backgroundColor: Colors.red,
            strokeWidth: 10,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        ),
        LabelText(
          '$totalCorrect / $totalQuestion',
        ),
      ],
    );
  }
}
