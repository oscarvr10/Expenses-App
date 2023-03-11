import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/utils/extensions.dart';
import 'package:exp_app/widgets/add_expenses_wt/category_list.dart';
import 'package:flutter/material.dart';

class BsCategory extends StatefulWidget {
  final CombinedModel cModel;

  const BsCategory({super.key, required this.cModel});

  @override
  State<BsCategory> createState() => _BsCategoryState();
}

class _BsCategoryState extends State<BsCategory> {
  @override
  Widget build(BuildContext context) {
    bool hasData = false;

    if (widget.cModel.category != 'Selecciona una categoría') {
      hasData = true;
    }

    return GestureDetector(
      onTap: () => _categorySelected(),
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

  void _itemsSelected(String category, String color, String icon) {
    setState(() {
      widget.cModel.category = category;
      widget.cModel.color = color;
      widget.cModel.icon = icon;
      Navigator.pop(context);
    });
  }

  _categorySelected() {
    var categoryList = CategoryList().catList;

    var _widgets = [
      ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 24.0),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categoryList.length,
        itemBuilder: (_, i) {
          var item = categoryList[i];
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
        },
      ),
    ];

    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0),
      )),
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
}
