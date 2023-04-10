import 'dart:math';
import 'package:exp_app/models/expenses_model.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/providers/ui_provider.dart';
import 'package:exp_app/utils/extensions.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/src/text_element.dart' as txtElement;
import 'package:charts_flutter/src/text_style.dart' as txtStyle;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ChartLine extends StatelessWidget {
  static String? pointAmount;
  static String? pointDay;

  const ChartLine({super.key});

  @override
  Widget build(BuildContext context) {
    var eList = context.watch<ExpensesProvider>().eList;
    var currentMonth = context.watch<UIProvider>().selectedMonth + 1;
    List<ExpensesModel> eModel = [];
    Map<int, dynamic> mapExp;
    List<double> perDayList = [];

    // Chart with Map
    mapExp = eList.fold({}, (Map<int, dynamic> map, exp) {
      if (!map.containsKey(exp.day)) {
        map[exp.day] = 0.0;
      }
      map[exp.day] += exp.expense;
      return map;
    });

    mapExp.forEach((key, value) {
      eModel.add(ExpensesModel(day: key, expense: value));
    });

    eModel.sort(((a, b) => a.day.compareTo(b.day))); //ordena por dias

    List<charts.Series<ExpensesModel, num>> series = [
      charts.Series<ExpensesModel, num>(
        id: 'ExpensesPerDay',
        domainFn: (v, i) => v.day,
        measureFn: (v, i) => v.expense,
        seriesColor: charts.MaterialPalette.green.shadeDefault,
        data: eModel,
      )
    ];

    // Chart with doubles
    var currentDay = daysInMonth(currentMonth);
    print(currentDay);

    perDayList = List.generate(currentDay + 1, (i) {
      return eList
          .where((e) => e.day == i)
          .map((e) => e.expense)
          .fold(0.0, (previousValue, element) => previousValue + element);
    });

    List<charts.Series<double, int>> series2 = [
      charts.Series<double, int>(
        id: 'ExpensesPerDay',
        domainFn: (v, i) => i!,
        measureFn: (v, i) => v,
        seriesColor: charts.MaterialPalette.green.shadeDefault,
        radiusPxFn: (v, i) {
          if (v == 0.0) return 0;
          return 4;
        },
        data: perDayList,
      )
    ];

    return SizedBox(
      child: charts.LineChart(
        series,
        animate: true,
        defaultRenderer: charts.LineRendererConfig(
          includePoints: true,
          includeArea: true,
          areaOpacity: 0.2,
        ),
        primaryMeasureAxis: charts.NumericAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
            lineStyle: charts.LineStyleSpec(
              color: charts.ColorUtil.fromDartColor(Colors.green[100]!),
            ),
            labelAnchor: charts.TickLabelAnchor.after,
            labelJustification: charts.TickLabelJustification.outside,
          ),
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
          tickProviderSpec: charts.StaticNumericTickProviderSpec(
            [
              const charts.TickSpec(0, label: '0'),
              const charts.TickSpec(5, label: '5'),
              const charts.TickSpec(10, label: '10'),
              const charts.TickSpec(15, label: '15'),
              const charts.TickSpec(20, label: '20'),
              const charts.TickSpec(25, label: '25'),
              charts.TickSpec(
                currentDay,
                label: currentDay.toString(),
              )
            ],
          ),
        ),
        selectionModels: [
          charts.SelectionModelConfig(
            changedListener: (model) {
              if (model.hasDatumSelection) {
                pointAmount = getAmountFormat(model.selectedSeries[0]
                    .measureFn(model.selectedDatum[0].index)!
                    .toDouble());

                pointDay = model.selectedSeries[0]
                    .domainFn(model.selectedDatum[0].index)
                    .toString();
              }
            },
          ),
        ],
        behaviors: [
          charts.LinePointHighlighter(
              showHorizontalFollowLine:
                  charts.LinePointHighlighterFollowLineType.nearest,
              showVerticalFollowLine:
                  charts.LinePointHighlighterFollowLineType.nearest,
              symbolRenderer: SymbolRender()),
          charts.SelectNearest(
            eventTrigger: charts.SelectionTrigger.tapAndDrag,
          ),
        ],
      ),
    );
  }
}

class SymbolRender extends charts.CircleSymbolRenderer {
  var style = txtStyle.TextStyle();

  @override
  void paint(
    charts.ChartCanvas canvas,
    Rectangle<num> bounds, {
    List<int>? dashPattern,
    charts.Color? fillColor,
    charts.FillPatternType? fillPattern,
    charts.Color? strokeColor,
    double? strokeWidthPx,
  }) {
    super.paint(
      canvas,
      bounds,
      dashPattern: dashPattern,
      fillColor: fillColor,
      fillPattern: fillPattern,
      strokeColor: strokeColor,
      strokeWidthPx: strokeWidthPx,
    );

    canvas.drawRect(
      Rectangle(
        bounds.left - 25,
        bounds.top - 25,
        bounds.width + 48,
        bounds.height + 28,
      ),
      fill: charts.ColorUtil.fromDartColor(Colors.grey[900]!),
      stroke: charts.ColorUtil.fromDartColor(Colors.white),
      strokeWidthPx: 1,
    );

    style.color = charts.MaterialPalette.white;
    style.fontSize = 10;
    style.fontWeight = 'bold';

    canvas.drawText(
      txtElement.TextElement(
        'Día ${ChartLine.pointDay}\n${ChartLine.pointAmount}',
        style: style,
      ),
      (bounds.left - 20).round(),
      (bounds.top - 14).round(),
    );
  }
}
