import 'package:exp_app/pages/add_entries.dart';
import 'package:exp_app/pages/add_expenses.dart';
import 'package:exp_app/utils/page_animation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key});

  @override
  Widget build(BuildContext context) {
    List<SpeedDialChild> childButtons = [];

    childButtons.add(SpeedDialChild(
      backgroundColor: Colors.red,
      child: const Icon(Icons.remove),
      label: 'Gasto',
      labelStyle: const TextStyle(fontSize: 16.0),
      onTap: () {
        Navigator.push(
          context,
          PageAnimationRoutes(
            widget: const AddExpenses(),
            axisX: 0.8,
            axisY: 0.8,
            curveAnimation: Curves.easeOutBack,
          ),
        );
      },
    ));

    childButtons.add(SpeedDialChild(
      backgroundColor: Colors.green,
      child: const Icon(Icons.add),
      label: 'Ingreso',
      labelStyle: const TextStyle(fontSize: 16.0),
      onTap: () {
        Navigator.push(
          context,
          PageAnimationRoutes(
            widget: const AddEntries(),
            axisX: 0.8,
            axisY: -0.8,
            curveAnimation: Curves.easeOutBack,
          ),
        );
      },
    ));

    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      spacing: 15.0,
      childMargin: const EdgeInsets.symmetric(horizontal: 10.0),
      childrenButtonSize: const Size(55.0, 55.0),
      children: childButtons,
    );
  }
}
