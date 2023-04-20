import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/widgets/balance_page_wt/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exp_app/utils/math_operations.dart';

class FlayerBalance extends StatelessWidget {
  const FlayerBalance({super.key});

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    final etList = context.watch<ExpensesProvider>().etList;
    double _totalExp = 0.0;
    double _totalEt = 0.0;
    double _total = 0.0;

    _totalExp = getTotalExpenses(eList);
    _totalEt = getTotalEntries(etList);
    _total = _totalEt - _totalExp;

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                dense: true,
                visualDensity: const VisualDensity(
                  vertical: -4,
                ),
                title: const Text('Ingresos'),
                trailing: Text(
                  getAmountFormat(_totalEt),
                  style: const TextStyle(color: Colors.green),
                ),
              ),
              ListTile(
                dense: true,
                visualDensity: const VisualDensity(
                  vertical: -4,
                ),
                title: const Text('Gastos'),
                trailing: Text(
                  getAmountFormat(_totalExp),
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              const Divider(
                indent: 15,
                endIndent: 15,
                thickness: 2.0,
              ),
              ListTile(
                dense: true,
                visualDensity: const VisualDensity(
                  vertical: -4,
                ),
                title: const Text('Balance'),
                trailing: Text(
                  getBalance(eList, etList),
                  style: TextStyle(
                    color: _total < 0 ? Colors.red : Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Expanded(
          flex: 2,
          child: SizedBox(
            height: 180.0,
            child: ChartBar(),
          ),
        ),
      ],
    );
  }
}
