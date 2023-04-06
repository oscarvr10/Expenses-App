import 'package:exp_app/utils/constants.dart';
import 'package:exp_app/widgets/balance_page_wt/flayer_categories.dart';
import 'package:exp_app/widgets/balance_page_wt/flayer_skin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/expenses_provider.dart';

class FrontSheet extends StatelessWidget {
  const FrontSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    bool hasData = false;

    if (eList.isNotEmpty) {
      hasData = true;
    }

    return Container(
      // height: 800.0,
      decoration: Constants.sheetBoxDecoration(
          Theme.of(context).scaffoldBackgroundColor),
      child: hasData
          ? ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                FlayerSkin(
                  title: 'Categorías de Gastos',
                  body: FlayerCategories(),
                ),
                FlayerSkin(
                  title: 'Frecuencia de Gastos',
                  body: SizedBox(
                    height: 150.0,
                  ),
                ),
                FlayerSkin(
                  title: 'Movimientos',
                  body: SizedBox(
                    height: 150.0,
                  ),
                ),
                FlayerSkin(
                  title: 'Balance General',
                  body: SizedBox(
                    height: 150.0,
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(50.0),
                  child: Image.asset('assets/empty2.png'),
                ),
                const Text(
                  'No hay gastos en este mes.\nAgrega uno nuevo',
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 14.0,
                    letterSpacing: 1.1,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
    );
  }
}
