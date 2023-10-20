import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  bool get isNullOrEmpty {
    return isEmpty;
  }

  bool get isNotNullOrEmpty {
    return isNotEmpty;
  }

  String get orEmpty => this;

  String removeZeroAtFirst() {
    if (startsWith('0') == true) {
      return replaceFirst('0', '');
    }
    return orEmpty;
  }
}

const String emptyString = '';

extension ContextExt on BuildContext {
  void navigateTo(Widget widget) {
    Navigator.push(
      this,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  void dismissKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

}

extension DateTimeExtension on DateTime? {
  /// default format is dd-MM-yyyy
  String formattedDate({String? format}) {
    if (this == null) return emptyString;
    return format != null
        ? DateFormat(format).format(this!)
        : DateFormat('dd-MM-yyyy').format(this!);
  }
}

extension EitherX<L, R> on Either<L, R> {
  R asRight() => (this as Right).value;
  L asLeft() => (this as Left).value;
}