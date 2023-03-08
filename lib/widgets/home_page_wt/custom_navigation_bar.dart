import 'package:exp_app/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    // final uiProvider = Provider.of<UiProvider>(context);

    final watchIndex = context.watch<UiProvider>();
    final read = context.read<UiProvider>();

    return BottomNavigationBar(
      currentIndex: watchIndex.bnbIndex,
      onTap: (int i) => read.bnbIndex = i,
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
