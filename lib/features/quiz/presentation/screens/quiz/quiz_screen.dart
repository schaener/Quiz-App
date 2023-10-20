import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapps/features/core/extension.dart';
import 'package:quizapps/features/quiz/data/models/result_model.dart';
import 'package:quizapps/features/quiz/logic/quizBloc/quiz_bloc.dart';
import 'package:quizapps/features/quiz/presentation/screens/score/result_screen.dart';

import '../../../../../injection.dart';
import '../../../../core/widgets/error.dart';
import '../../../../core/widgets/spacer.dart';
import '../../../../core/widgets/text.dart';

class QuizScreen extends StatelessWidget {
  final String? topicId;

  const QuizScreen({super.key, this.topicId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<QuizBloc>()
        ..add(
          QuizEvent.startQuizEvent(topicId: topicId),
        ),
      child: BlocListener<QuizBloc, QuizState>(
        listener: (context, state) {
          if (state.isShowResult == true) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<QuizBloc>(),
                  child: const ResultScreen(),
                ),
              ),
            );
          }
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Quiz Page'),
              centerTitle: true,
              foregroundColor: Colors.white,
              backgroundColor: Colors.transparent,
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: LabelText('Exit'),
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                BlocBuilder<QuizBloc, QuizState>(
                  buildWhen: (previous, current) =>
                      previous.duration != current.duration,
                  builder: (context, state) {
                    return LinearProgressIndicator(
                      value: state.duration.toDouble() / 30,
                    );
                  },
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      const VerticalSpacer(),
                      _QuestionSection(topicId: topicId),
                      const VerticalSpacer(),
                      _AnswerSection(topicId: topicId),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class _QuestionSection extends StatelessWidget {
  final String? topicId;

  const _QuestionSection({required this.topicId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(builder: (context, state) {
      if (state.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state.questions?.isRight() == true &&
          state.currentQuestion != null) {
        final question = state.currentQuestion;
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TitleText(
                  question?.question ?? emptyString,
                  color: Colors.black,
                ),
                ...?question?.assets
                    ?.map(
                      (url) => Image.network(url),
                    )
                    .toList(),
              ],
            ),
          ),
        );
      }

      return ErrorContainer(
        onRetry: () {
          context.read<QuizBloc>().add(
                QuizEvent.startQuizEvent(topicId: topicId),
              );
        },
      );
    });
  }
}

class _AnswerSection extends StatelessWidget {
  final String? topicId;

  const _AnswerSection({required this.topicId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.questions?.isRight() == true) {
          final question = state.currentQuestion;
          return Column(
            children: [
              ...?question?.answers?.map((answer) {
                return Column(
                  children: [
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      trailing: state.isShowAnswer
                          ? answer.isCorrect
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                )
                          : null,
                      selected: true,
                      selectedTileColor: Colors.white,
                      title: Center(
                          child: TitleText(
                        answer.text,
                        color: Colors.black,
                      )),
                      onTap: state.isShowAnswer
                          ? null
                          : () {
                              context.read<QuizBloc>().add(
                                    QuizEvent.checkAnswerEvent(
                                      answer: ResultAnswerModel(
                                        question: question,
                                        answer: answer.text,
                                        isCorrect: answer.isCorrect,
                                      ),
                                    ),
                                  );
                            },
                    ),
                    const VerticalSpacer(),
                  ],
                );
              }).toList(),
            ],
          );
        }

        return ErrorContainer(
          onRetry: () {
            context.read<QuizBloc>().add(
                  QuizEvent.startQuizEvent(topicId: topicId),
                );
          },
        );
      },
    );
  }
}
