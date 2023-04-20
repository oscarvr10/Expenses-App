import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:exp_app/widgets/global_wt/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class FlayerMovements extends StatelessWidget {
  const FlayerMovements({super.key});

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    final etList = context.watch<ExpensesProvider>().etList;
    double totalExp = 0.0;
    double totalEt = 0.0;

    totalExp = getTotalExpenses(eList);
    totalEt = getTotalEntries(etList);

    return SizedBox(
      height: 180.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: PercentCircular(
              percent: totalExp / totalEt,
              radius: 70.0,
              color: Colors.green,
              arcType: ArcType.FULL,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 130.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gastos Realizados',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    getAmountFormat(totalExp),
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Absorbe un ${(totalExp / totalEt * 100).toStringAsFixed(2)}% de tus ingresos',
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
