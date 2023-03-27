import 'package:exp_app/models/features_model.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:exp_app/utils/extensions.dart';
import 'package:exp_app/widgets/add_expenses_wt/create_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminCategory extends StatelessWidget {
  const AdminCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final flist = context.watch<ExpensesProvider>().fList;

    return SafeArea(
      child: ListView.builder(
        itemCount: flist.length,
        padding: const EdgeInsets.only(top: 24.0),
        itemBuilder: (context, i) {
          var item = flist[i];
          return ListTile(
            leading: Icon(
              item.icon.toIcon(),
              size: 35.0,
              color: item.color.toColor(),
            ),
            title: Text(item.category),
            trailing: const Icon(
              Icons.edit,
              size: 25.0,
            ),
            onTap: () {
              Navigator.pop(context);
              _createCategory(context, item);
            },
          );
        },
      ),
    );
  }

  _createCategory(BuildContext context, FeaturesModel fModel) {
    var feature = FeaturesModel(
      id: fModel.id,
      category: fModel.category,
      color: fModel.color,
      icon: fModel.icon,
    );
    showModalBottomSheet(
      shape: Constants.bottomSheetBorder(),
      context: context,
      builder: (_) => CreateCategory(fModel: feature),
    );
  }
}
