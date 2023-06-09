import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:exp_app/widgets/add_expenses_wt/date_picker.dart';
import 'package:flutter/material.dart';

import '../widgets/add_entries_wt/save_et_button.dart';
import '../widgets/add_expenses_wt/bs_num_keyboard.dart';
import '../widgets/add_expenses_wt/comment_box.dart';

class AddEntries extends StatelessWidget {
  const AddEntries({super.key});

  @override
  Widget build(BuildContext context) {
    CombinedModel cModel = CombinedModel();
    bool hasData = false;

    final editCModel =
        ModalRoute.of(context)!.settings.arguments as CombinedModel?;

    if (editCModel != null) {
      cModel = editCModel;
      hasData = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: hasData
            ? const Text('Editar Ingreso')
            : const Text('Agregar Ingreso'),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          BSNumKeyboard(cModel: cModel),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: Constants.sheetBoxDecoration(
                Theme.of(context).primaryColorDark,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DatePicker(cModel: cModel),
                  CommentBox(cModel: cModel),
                  Expanded(
                    child: Center(
                        child: SaveEtButton(
                      cModel: cModel,
                      hasData: hasData,
                    )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
