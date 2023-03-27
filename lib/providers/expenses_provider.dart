import 'package:exp_app/models/features_model.dart';
import 'package:exp_app/providers/db_features.dart';
import 'package:flutter/material.dart';

class ExpensesProvider extends ChangeNotifier {
  List<FeaturesModel> fList = [];

  addNewFeature(FeaturesModel newFeature) async {
    final id = await DBFeatures.db.addNewFeature(newFeature);
    newFeature.id = id;

    fList.add(newFeature);
    notifyListeners();
  }

  getAllFeatures() async {
    final response = await DBFeatures.db.getAllFeatures();

    fList = [...response];
    notifyListeners();
  }

  updateFeature(FeaturesModel feature) async {
    await DBFeatures.db.updateFeature(feature);
    getAllFeatures();
  }
}
