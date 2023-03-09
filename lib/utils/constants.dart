import 'package:flutter/widgets.dart';

class Constants {
  static sheetBoxDecoration(Color color) {
    return BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ));
  }

  static customButton(
      Color decorationColor, Color borderColor, String textButton) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: decorationColor,
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Center(
          child: Text(textButton),
        ),
      ),
    );
  }
}
