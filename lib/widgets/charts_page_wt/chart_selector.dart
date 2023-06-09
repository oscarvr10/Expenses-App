import 'package:exp_app/providers/ui_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartSelector extends StatefulWidget {
  const ChartSelector({super.key});

  @override
  State<ChartSelector> createState() => _ChartSelectorState();
}

class _ChartSelectorState extends State<ChartSelector> {
  @override
  Widget build(BuildContext context) {
    final currentChart = context.watch<UIProvider>().selectedChart;
    final uiProvider = context.read<UIProvider>();

    var widgets = <Widget>[];

    Map<String, IconData> typeChart = {
      'Gráfico Lineal': Icons.show_chart_outlined,
      'Gráfico Pie': CupertinoIcons.chart_pie,
      'Gráfico de Dispersión': Icons.bubble_chart_outlined,
    };

    typeChart.forEach(
      (name, icon) {
        widgets.add(
          GestureDetector(
            onTap: () {
              setState(() {
                uiProvider.selectedChart = name;
              });
            },
            child: BubbleTab(
              icon: icon,
              selected: currentChart == name ? true : false,
            ),
          ),
        );
      },
    );
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 25.0),
      child: Wrap(
        spacing: 8.0,
        children: widgets,
      ),
    );
  }
}

class BubbleTab extends StatelessWidget {
  final bool selected;
  final IconData icon;

  const BubbleTab({
    super.key,
    required this.selected,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: selected ? Colors.green : Colors.transparent,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Icon(icon),
    );
  }
}
