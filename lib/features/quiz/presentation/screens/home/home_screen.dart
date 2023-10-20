import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:quizapps/features/core/extension.dart';
import 'package:quizapps/features/core/widgets/spacer.dart';
import 'package:quizapps/features/core/widgets/text.dart';
import 'package:quizapps/features/quiz/presentation/screens/quiz/quiz_screen.dart';
import 'package:quizapps/features/quiz/presentation/screens/topic/topic_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _HeadingSection(),
            VerticalSpacer(val: 20),
            _MenuSection(),
            VerticalSpacer(val: 20),
            _FooterSection(),
          ],
        ),
      ),
    ));
  }
}

class _HeadingSection extends StatelessWidget {
  const _HeadingSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.lightbulb, // Replace with the desired icon
          color: Colors.yellow, // Set the icon color
          size: 70.0, // Set the icon size
        ),
        Padding(
          padding: EdgeInsets.only(top: 45.0), // Adjust the value as needed
          child: Text(
            'Flutter Quiz App',
            style: TextStyle(
              color: Colors.white, // Set the text color to white
              fontSize: 22,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 13.0),
          child: Text(
            'Learn . Take Quiz . Repeat',
            style: TextStyle(
                color: Colors.white, // Set the text color to white
                fontSize: 12
                // Your other text style properties here
                ),
          ),
        ),
      ],
    );
  }
}

class _MenuSection extends StatelessWidget {
  const _MenuSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
            onPressed: () {
              context.navigateTo(const QuizScreen());
            },
            child: const ButtonText('Play'),
          ),
        ),
        const VerticalSpacer(),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: const StadiumBorder(),
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
            onPressed: () {
              context.navigateTo(const TopicScreen());
            },
            child: ButtonText(
              'Topics',
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton.icon(
          onPressed: () {
            Share.share(
              'Download now on Google Play Store'
              '\n\n'
              'https://play.google.com/store/apps/details?id=id.quizapps&hl=id',
            );
          },
          icon: Icon(Icons.share, color: Theme.of(context).colorScheme.primary),
          label: const ButtonText('Share'),
        ),
        TextButton.icon(
          onPressed: () {
            if (Platform.isAndroid || Platform.isIOS) {
              final appId = Platform.isAndroid ? 'com.whatsapp' : 'com.google';
              final url = Uri.parse(
                Platform.isAndroid
                    ? "market://details?id=$appId"
                    : "https://apps.apple.com/app/id$appId",
              );
              launchUrl(
                url,
                mode: LaunchMode.externalApplication,
              );
            }
          },
          icon: const Icon(Icons.star, color: Colors.yellow),
          label: const ButtonText('Rate Us'),
        ),
      ],
    );
  }
}
