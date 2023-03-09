import 'package:exp_app/utils/constants.dart';
import 'package:flutter/material.dart';

import '../widgets/add_expenses_wt/bs_num_keyboard.dart';
import '../widgets/add_expenses_wt/comment_box.dart';

class AddExpenses extends StatelessWidget {
  const AddExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Agregar Gasto'),
          elevation: 0.0,
        ),
        body: Column(
          children: [
            const BSNumKeyboard(),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: Constants.sheetBoxDecoration(
                  Theme.of(context).primaryColorDark,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Fecha 12/12/12'),
                    Text('Seleccionar categoría'),
                    Text('Agregar Comentario )opcional)'),
                    CommentBox(),
                    Expanded(
                      child: Center(
                        child: Text('Ok'),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
