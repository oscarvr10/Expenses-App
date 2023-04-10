import 'package:exp_app/utils/icon_list.dart';
import 'package:flutter/material.dart';
export 'package:exp_app/utils/extensions.dart';

int daysInMonth(int month) {
  var currentDate = DateTime.now();
  var lastDay = month < 12
      ? DateTime(currentDate.year, month + 1, 0)
      : DateTime(currentDate.year + 1, 1, 0);

  return lastDay.day;
}

extension ColorExtension on String {
  toColor() {
    String hexColor = replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'ff$hexColor';
    }

    if (hexColor.length == 8) {
      return Color(int.parse('0x$hexColor'));
    }
  }
}

extension IconExtension on String {
  toIcon() {
    return IconList().iconMap[this];
  }
}
