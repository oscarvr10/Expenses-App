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
  const _HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    // final expProvider = Provider.of<ExpensesProvider>(context, listen: false);
    final expProvider = context.read<ExpensesProvider>();
    final currentIndex = uiProvider.bnbIndex;
    final DateTime _currentDate = DateTime.now();

    switch (currentIndex) {
      case 0:
        expProvider.getExpensesByDate(_currentDate.month, _currentDate.year);
        expProvider.getAllFeatures();
        return const BalancePage();
      case 1:
        return const ChartsPage();
      default:
        return const BalancePage();
    }
  }
}
