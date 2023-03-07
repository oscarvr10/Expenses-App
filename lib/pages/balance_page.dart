import 'dart:math';

import 'package:exp_app/widgets/balance_page_wt/back_sheet.dart';
import 'package:exp_app/widgets/balance_page_wt/front_sheet.dart';
import 'package:flutter/material.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  final _scrollController = ScrollController();
  double _offset = 0;

  double get _max => max(90 - _offset * 90, 0.0);

  void _listener() {
    setState(() {
      _offset = _scrollController.offset / 100;
      print(_max);
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
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          elevation: 0.0,
          expandedHeight: 130.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '\$ 2500.00',
                  style: TextStyle(fontSize: 34.0, color: Colors.green),
                ),
                Text('Balance', style: TextStyle(fontSize: 16.0))
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
    );
  }
}
