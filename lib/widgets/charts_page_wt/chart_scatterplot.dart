import 'package:charts_flutter/flutter.dart' as charts;
import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/providers/ui_provider.dart';
import 'package:exp_app/utils/extensions.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ChartScatterPlot extends StatefulWidget {
  const ChartScatterPlot({super.key});

  @override
  State<ChartScatterPlot> createState() => _ChartScatterPlotState();
}

class _ChartScatterPlotState extends State<ChartScatterPlot> {
  String catName = 'Total';
  double catAmount = 0.0;
  int catDay = 0;
  int _index = -1;
  bool _animated = true;

  @override
  void initState() {
    super.initState();
    catAmount = context
        .read<ExpensesProvider>()
        .eList
        .map((e) => e.expense)
        .fold(0.0, (previousValue, element) => previousValue + element);
  }

  @override
  Widget build(BuildContext context) {
    dynamic cList = context.watch<ExpensesProvider>().allExpensesList;
    final currentMonth = context.watch<UIProvider>().selectedMonth + 1;
    var currentDay = daysInMonth(currentMonth);

    var maxExp = cList.fold(0.0, (a, b) => a < b.amount ? b.amount : a);

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Positioned(
          top: -1,
          left: 35,
          child: Text('Día: $catDay'),
        ),
        Positioned(
          top: -1,
          right: 40,
          child: Text('$catName: ${getAmountFormat(catAmount)}'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: charts.ScatterPlotChart(
            _series(cList, maxExp, _index),
            animate: _animated,
            primaryMeasureAxis: charts.NumericAxisSpec(
              tickFormatterSpec:
                  charts.BasicNumericTickFormatterSpec.fromNumberFormat(
                NumberFormat.simpleCurrency(
                  decimalDigits: 0,
                ),
              ),
              tickProviderSpec: const charts.BasicNumericTickProviderSpec(
                desiredTickCount: 6,
              ),
            ),
            domainAxis: charts.NumericAxisSpec(
              tickProviderSpec: charts.StaticNumericTickProviderSpec([
                const charts.TickSpec(0, label: '0'),
                const charts.TickSpec(5, label: '5'),
                const charts.TickSpec(10, label: '10'),
                const charts.TickSpec(15, label: '15'),
                const charts.TickSpec(20, label: '20'),
                const charts.TickSpec(25, label: '25'),
                charts.TickSpec(currentDay, label: '$currentDay'),
              ]),
            ),
            selectionModels: [
              charts.SelectionModelConfig(
                changedListener: (model) {
                  if (model.hasDatumSelection) {
                    setState(() {
                      _animated = false;
                      _index = model.selectedDatum[0].index!;
                      catName = model.selectedSeries[0]
                          .labelAccessorFn!(model.selectedDatum[0].index);
                      catAmount = model.selectedSeries[0]
                          .measureFn(model.selectedDatum[0].index)!
                          .toDouble();
                      catDay = model.selectedSeries[0]
                          .domainFn(model.selectedDatum[0].index)
                          .toInt();
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<charts.Series<CombinedModel, num>> _series(
      List<CombinedModel> cList, dynamic maxExp, int index) {
    return [
      charts.Series<CombinedModel, num>(
        id: 'ScatterPlot',
        domainFn: (v, i) => v.day,
        measureFn: (v, i) => v.amount,
        labelAccessorFn: (v, i) => v.category,
        colorFn: (v, i) {
          var onTap = i == index;
          return onTap
              ? charts.ColorUtil.fromDartColor(v.color.toColor()).darker
              : charts.ColorUtil.fromDartColor(v.color.toColor());
        },
        radiusPxFn: (v, i) {
          var onTap = i == index;
          final bucket = v.amount / maxExp;
          if (bucket < 1 / 4) {
            return onTap ? 4 : 3;
          } else if (bucket < 2 / 4) {
            return onTap ? 7 : 6;
          } else {
            return onTap ? 10 : 9;
          }
        },
        data: cList,
      ),
    ];
  }
}
