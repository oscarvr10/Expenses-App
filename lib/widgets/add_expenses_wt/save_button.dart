import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/providers/ui_provider.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SaveButton extends StatelessWidget {
  final CombinedModel cModel;
  final bool hasData;

  const SaveButton({super.key, required this.cModel, required this.hasData});

  @override
  Widget build(BuildContext context) {
    final exProvider = context.read<ExpensesProvider>();
    final uiProvider = context.read<UIProvider>();

    return GestureDetector(
      onTap: () {
        if (cModel.amount != 0.0 && cModel.link != null) {
          hasData
              ? exProvider.updateExpense(cModel)
              : exProvider.addNewExpense(cModel);
          Fluttertoast.showToast(
              msg: hasData
                  ? 'Gasto editado correctamente.'
                  : 'Gasto agregado correctamente.',
              backgroundColor: Colors.green);
          uiProvider.bnbIndex = 0;
          Navigator.pop(context);
        } else if (cModel.amount == 0.0) {
          Fluttertoast.showToast(
              msg: 'Debes especificar un monto para el gasto.',
              backgroundColor: Colors.red);
        } else {
          Fluttertoast.showToast(
              msg: 'Debes seleccionar una categoría para el gasto.',
              backgroundColor: Colors.red);
        }
      },
      child: SizedBox(
        height: 70.0,
        width: 170.0,
        child: Constants.customButton(
            Colors.green, Colors.white, hasData ? 'EDITAR' : 'GUARDAR'),
      ),
    );
  }
}
