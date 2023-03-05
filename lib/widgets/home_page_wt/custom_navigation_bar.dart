import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0.0,
      items: const [
        BottomNavigationBarItem(
            label: 'Balance', icon: Icon(Icons.account_balance_outlined)),
        BottomNavigationBarItem(
            label: 'Gráficos', icon: Icon(Icons.bar_chart_outlined)),
        BottomNavigationBarItem(
            label: 'Configuración', icon: Icon(Icons.settings)),
      ],
    );
  }
}
