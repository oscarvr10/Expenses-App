import 'package:exp_app/pages/balance_page.dart';
import 'package:flutter/material.dart';

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
    const currentIndex = 1;

    switch (currentIndex) {
      case 0:
        return const BalancePage();
      case 1:
        return const ChartsPage();
      default:
        return const BalancePage();
    }
  }
}
