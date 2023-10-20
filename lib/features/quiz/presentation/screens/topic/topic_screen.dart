import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapps/features/core/extension.dart';
import 'package:quizapps/features/core/widgets/error.dart';
import 'package:quizapps/features/core/widgets/spacer.dart';
import 'package:quizapps/features/core/widgets/text.dart';
import 'package:quizapps/features/quiz/logic/topicBloc/topic_bloc.dart';
import 'package:quizapps/features/quiz/presentation/screens/quiz/quiz_screen.dart';

import '../../../../../injection.dart';

class TopicScreen extends StatelessWidget {
  const TopicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TopicBloc>()
        ..add(
          const TopicEvent.getTopicsEvent(),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Topics'),
          centerTitle: true,
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
        ),
        body: BlocBuilder<TopicBloc, TopicState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.topics?.isLeft() == true) {
              return ErrorContainer(
                onRetry: () {
                  context.read<TopicBloc>().add(
                        const TopicEvent.getTopicsEvent(),
                      );
                },
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: state.topics?.asRight().length ?? 0,
              itemBuilder: (context, index) {
                final topic = state.topics?.asRight()[index];
                return Column(
                  children: [
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      selected: true,
                      selectedTileColor: const Color(0xFF193368),
                      title: ButtonText(
                        topic?.title ?? emptyString,
                      ),
                      trailing: const Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                      ),
                      onTap: () {
                        context.navigateTo(
                          QuizScreen(topicId: topic?.id),
                        );
                      },
                    ),
                    const VerticalSpacer()
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
