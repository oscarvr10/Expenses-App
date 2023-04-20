import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/extensions.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartPieFlayer extends StatefulWidget {
  const ChartPieFlayer({super.key});

  @override
  State<ChartPieFlayer> createState() => _ChartPieFlayerState();
}

class _ChartPieFlayerState extends State<ChartPieFlayer> {
  int _index = 0;
  bool _animate = true;

  @override
  Widget build(BuildContext context) {
    var gList = context.watch<ExpensesProvider>().groupExpensesList;
    double totalOthers = 0;

    if (_index >= gList.length) {
      _index = 0;
    }
    if (gList.length >= 6) {
      totalOthers = gList
          .sublist(5)
          .map((e) => e.amount)
          .fold(0.0, (previousValue, element) => previousValue + element);
      gList = gList.sublist(0, 5).toList();
      gList.add(CombinedModel(
        category: 'Otros',
        amount: totalOthers,
        icon: 'otros',
        color: '#20634b',
      ));
    }
    var item = gList[_index];

    return Stack(
      alignment: Alignment.center,
      children: [
        charts.PieChart<String>(
          _series(gList, _index),
          animate: _animate,
          animationDuration: const Duration(milliseconds: 900),
          defaultInteractions: true,
          defaultRenderer: charts.ArcRendererConfig(
            // arcWidth: 45,
            strokeWidthPx: 2.0,
            arcRatio: 0.4,
          ),
          selectionModels: [
            charts.SelectionModelConfig(
                type: charts.SelectionModelType.info,
                changedListener: (charts.SelectionModel model) {
                  if (model.hasDatumSelection) {
                    setState(() {
                      _animate = false;
                      _index = model.selectedDatum[0].index!;
                    });
                  }
                }),
          ],
        ),
        SizedBox(
          width: 50.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Icon(
                  item.icon.toIcon(),
                  color: item.color.toColor(),
                ),
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(item.category),
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(getAmountFormat(item.amount)),
              ),
            ],
          ),
        )
      ],
    );
  }

  List<charts.Series<CombinedModel, String>> _series(
      List<CombinedModel> gList, int index) {
    return [
      charts.Series<CombinedModel, String>(
        id: 'PieChart',
        domainFn: (v, i) => v.category,
        measureFn: (v, i) => v.amount,
        keyFn: (v, i) => v.icon,
        colorFn: (v, i) {
          var onTap = i == index;
          if (!onTap) {
            return charts.ColorUtil.fromDartColor(v.color.toColor());
          }
          return charts.ColorUtil.fromDartColor(v.color.toColor()).darker;
        },
        data: gList,
      ),
    ];
  }
}
