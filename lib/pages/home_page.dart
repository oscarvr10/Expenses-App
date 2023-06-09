import 'package:exp_app/pages/settings_page.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:exp_app/pages/balance_page.dart';
import '../providers/ui_provider.dart';
import '../widgets/home_page_wt/custom_navigation_bar.dart';
import 'charts_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomNavigationBar(),
      body: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    // final expProvider = Provider.of<ExpensesProvider>(context, listen: false);
    final expProvider = context.read<ExpensesProvider>();
    final DateTime currentDate = DateTime.now();

    final currentIndex = uiProvider.bnbIndex;
    final currentMonth = uiProvider.selectedMonth + 1;

    switch (currentIndex) {
      case 0:
        expProvider.getExpensesByDate(currentMonth, currentDate.year);
        expProvider.getEntriesByDate(currentMonth, currentDate.year);
        expProvider.getAllFeatures();
        return const BalancePage();
      case 1:
        return const ChartsPage();
      case 2:
        return const SettingsPage();
      default:
        return const BalancePage();
    }
  }
}
