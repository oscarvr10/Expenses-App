import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/utils/extensions.dart';
import 'package:exp_app/widgets/add_expenses_wt/admin_category.dart';
import 'package:exp_app/widgets/add_expenses_wt/category_list.dart';
import 'package:exp_app/widgets/add_expenses_wt/create_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/features_model.dart';
import '../../providers/expenses_provider.dart';
import '../../utils/constants.dart';

class BsCategory extends StatefulWidget {
  final CombinedModel cModel;

  const BsCategory({super.key, required this.cModel});

  @override
  State<BsCategory> createState() => _BsCategoryState();
}

class _BsCategoryState extends State<BsCategory> {
  var categoryList = CategoryList().catList;
  final FeaturesModel fModel = FeaturesModel();

  @override
  void initState() {
    var expProvider = context.read<ExpensesProvider>();
    if (expProvider.fList.isEmpty) {
      for (var item in categoryList) {
        expProvider.addNewFeature(item);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final featureList = context.watch<ExpensesProvider>().fList;
    bool hasData = false;

    if (widget.cModel.category != 'Selecciona una categoría') {
      hasData = true;
    }

    return GestureDetector(
      onTap: () => _categorySelected(featureList),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            Icon(
              (hasData) ? widget.cModel.icon.toIcon() : Icons.category_outlined,
              size: 35.0,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.8,
                    color: (hasData)
                        ? widget.cModel.color.toColor()
                        : Theme.of(context).dividerColor,
                  ),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Center(
                  child: Text(widget.cModel.category),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _itemsSelected(String category, String color, String icon, int link) {
    setState(() {
      widget.cModel.link = link;
      widget.cModel.category = category;
      widget.cModel.color = color;
      widget.cModel.icon = icon;
      Navigator.pop(context);
    });
  }

  _categorySelected(List<FeaturesModel> fList) {
    var _widgets = [
      ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 24.0),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: fList.length,
        itemBuilder: (_, i) {
          var item = fList[i];
          return ListTile(
            leading: Icon(
              item.icon.toIcon(),
              color: item.color.toColor(),
              size: 30.0,
            ),
            title: Text(item.category),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 20.0,
            ),
            onTap: () => _itemsSelected(
              item.category,
              item.color,
              item.icon,
              item.id!,
            ),
          );
        },
      ),
      const Divider(thickness: 2.0),
      ListTile(
        leading: const Icon(
          Icons.create_new_folder_outlined,
          size: 30.0,
        ),
        title: const Text('Crear nueva categoría'),
        trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 25.0),
        onTap: () {
          Navigator.pop(context);
          _createNewCategory();
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.edit_outlined,
          size: 30.0,
        ),
        title: const Text('Administrar categoría'),
        trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 25.0),
        onTap: () {
          Navigator.pop(context);
          _adminCategory();
        },
      ),
    ];

    showModalBottomSheet(
      shape: Constants.bottomSheetBorder(),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 1.7,
          child: ListView(
            children: _widgets,
          ),
        );
      },
    );
  }

  _adminCategory() {
    showModalBottomSheet(
      shape: Constants.bottomSheetBorder(),
      isDismissible: false,
      context: context,
      builder: (context) => const AdminCategory(),
    );
  }

  _createNewCategory() {
    var features = FeaturesModel(
      id: fModel.id,
      category: fModel.category,
      color: fModel.color,
      icon: fModel.icon,
    );
    showModalBottomSheet(
      shape: Constants.bottomSheetBorder(),
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (context) => CreateCategory(fModel: features),
    );
  }
}
