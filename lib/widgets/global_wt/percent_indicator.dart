import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PercentLinear extends StatelessWidget {
  final double percent;
  final Color color;

  const PercentLinear({super.key, required this.percent, required this.color});

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      animation: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      lineHeight: 16.0,
      percent: percent,
      barRadius: const Radius.circular(10.0),
      // progressColor: color,
      linearGradient: LinearGradient(
        colors: [Colors.grey.shade100, color, color],
      ),
      center: Text(
        '${(percent * 100).toStringAsFixed(2)}%',
        style: const TextStyle(
          fontSize: 14.0,
        ),
      ),
    );
  }
}

class PercentCircular extends StatelessWidget {
  final double percent;
  final double radius;
  final Color color;
  final ArcType arcType;

  const PercentCircular({
    super.key,
    required this.percent,
    required this.radius,
    required this.color,
    required this.arcType,
  });

  @override
  Widget build(BuildContext context) {
    var percentValue = percent;
    if (percentValue > 1) {
      percentValue = 1;
    }

    return CircularPercentIndicator(
      animation: true,
      animationDuration: 800,
      percent: percentValue,
      radius: radius,
      progressColor: color,
      arcType: arcType,
      backgroundWidth: 0.0,
      lineWidth: 12.0,
      circularStrokeCap: CircularStrokeCap.round,
      center: Text(
        '${(percentValue * 100).toStringAsFixed(0)}%',
        style: const TextStyle(fontSize: 25.0),
      ),
    );
  }
}
