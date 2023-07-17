import 'package:flutter/material.dart';

extension DurationExtensions on int {
  Duration get microseconds => Duration(microseconds: this);

  Duration get milliseconds => Duration(milliseconds: this);

  Duration get seconds => Duration(seconds: this);

  Duration get minutes => Duration(minutes: this);

  Duration get hours => Duration(hours: this);

  Duration get days => Duration(days: this);

  Duration get ms => milliseconds;
}

extension DateTimeExtension on DateTime? {
  String get dayAgo {
    if (this == null) return '';
    final currentDate = DateTime.now();
    if (this!.day == currentDate.day &&
        this!.month == currentDate.month &&
        this!.year == currentDate.year) {
      return 'Today, ${this!.hour}:${this!.minute}';
    }
    final yesterday = currentDate.subtract(1.days).day;
    if (this!.day == yesterday &&
        this!.month == currentDate.month &&
        this!.year == currentDate.year) {
      return 'Yesterday';
    }
    if (this!.day < yesterday) {
      return '${currentDate.difference(this!).inDays} Days Ago';
    }
    return '';
  }
}

extension StringExtension on String {
  String upperCaseFirstLatter() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
