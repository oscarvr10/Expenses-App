import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SaveButton extends StatelessWidget {
  final CombinedModel cModel;
  const SaveButton({super.key, required this.cModel});

  @override
  Widget build(BuildContext context) {
    final exProvider = context.read<ExpensesProvider>();

    return GestureDetector(
      onTap: () {
        if (cModel.amount != 0.0 && cModel.link != null) {
          exProvider.addNewExpense(cModel);
          Fluttertoast.showToast(
              msg: 'Gasto agregado correctamente.',
              backgroundColor: Colors.green);
        } else if (cModel.amount == 0.0) {
          Fluttertoast.showToast(
              msg: 'Debes agregar un monto para el gasto.',
              backgroundColor: Colors.red);
        } else {
          Fluttertoast.showToast(
              msg: 'Debes agregar una categoría para el gasto.',
              backgroundColor: Colors.red);
        }
      },
      child: SizedBox(
        height: 70.0,
        width: 170.0,
        child: Constants.customButton(Colors.green, Colors.white, 'GUARDAR'),
      ),
    );
  }
}
