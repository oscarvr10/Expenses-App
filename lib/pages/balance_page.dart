import 'dart:math';

import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:exp_app/widgets/balance_page_wt/back_sheet.dart';
import 'package:exp_app/widgets/balance_page_wt/custom_fab.dart';
import 'package:exp_app/widgets/balance_page_wt/front_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/balance_page_wt/month_selector.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  final _scrollController = ScrollController();
  double _offset = 0;

  double get _max => max(80 - _offset * 80, 0.0);

  void _listener() {
    setState(() {
      _offset = _scrollController.offset / 100;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_listener);
    _max;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    final etList = context.watch<ExpensesProvider>().etList;

    return Scaffold(
      floatingActionButton: const CustomFAB(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            elevation: 0.0,
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MonthSelector(),
                  Text(
                    getBalance(eList, etList),
                    style: const TextStyle(fontSize: 34.0, color: Colors.green),
                  ),
                  const Text('Balance', style: TextStyle(fontSize: 16.0))
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Stack(
                children: [
                  const BackSheet(),
                  Padding(
                    padding: EdgeInsets.only(top: _max),
                    child: const FrontSheet(),
                  )
                ],
              )
            ]),
          )
        ],
      ),
    );
  }
}
