import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText(
    this.text, {
    Key? key,
    this.color = Colors.white,
  }) : super(key: key);
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: color,
      ),
    );
  }
}

class ButtonText extends StatelessWidget {
  const ButtonText(
    this.text, {
    Key? key,
    this.color = Colors.white,
  }) : super(key: key);
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: color,
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  const LabelText(
    this.text, {
    Key? key,
    this.color = Colors.white,
  }) : super(key: key);
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: color,
      ),
    );
  }
}
