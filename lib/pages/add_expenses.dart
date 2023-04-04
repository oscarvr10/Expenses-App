import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:exp_app/widgets/add_expenses_wt/bs_category.dart';
import 'package:exp_app/widgets/add_expenses_wt/date_picker.dart';
import 'package:exp_app/widgets/add_expenses_wt/save_button.dart';
import 'package:flutter/material.dart';

import '../widgets/add_expenses_wt/bs_num_keyboard.dart';
import '../widgets/add_expenses_wt/comment_box.dart';

class AddExpenses extends StatelessWidget {
  const AddExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    CombinedModel cModel = CombinedModel();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Gasto'),
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
                  BsCategory(cModel: cModel),
                  CommentBox(cModel: cModel),
                  Expanded(
                    child: Center(
                        child: SaveButton(
                      cModel: cModel,
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
