import 'dart:convert';

import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/models/expenses_model.dart';
import 'package:exp_app/models/features_model.dart';
import 'package:exp_app/providers/db_expenses.dart';
import 'package:exp_app/providers/db_features.dart';
import 'package:flutter/material.dart';

class ExpensesProvider extends ChangeNotifier {
  List<FeaturesModel> fList = [];
  List<ExpensesModel> eList = [];
  List<CombinedModel> cList = [];

/* 
  ---- Functions to insert ----
*/
  addNewFeature(FeaturesModel newFeature) async {
    final id = await DBFeatures.db.addNewFeature(newFeature);
    newFeature.id = id;

    fList.add(newFeature);
    notifyListeners();
  }

  addNewExpense(CombinedModel cModel) async {
    var expenses = ExpensesModel(
      link: cModel.link,
      year: cModel.year,
      month: cModel.month,
      day: cModel.day,
      comment: cModel.comment,
      expense: cModel.amount,
    );

    final id = await DBExpenses.db.addNewExpense(expenses);
    expenses.id = id;

    eList.add(expenses);
    notifyListeners();
  }

  /* 
    ---- Functions to read ----
  */
  getAllFeatures() async {
    final response = await DBFeatures.db.getAllFeatures();

    fList = [...response];
    notifyListeners();
  }

  getExpensesByDate(int month, int year) async {
    final response = await DBExpenses.db.getExpenseByDate(month, year);

    eList = [...response];
    notifyListeners();
  }

  /* 
    ---- Functions to update ----
  */
  updateFeature(FeaturesModel feature) async {
    await DBFeatures.db.updateFeature(feature);
    getAllFeatures();
  }

  updateExpense(CombinedModel cModel) async {
    var expenses = ExpensesModel(
      id: cModel.id,
      link: cModel.link,
      year: cModel.year,
      month: cModel.month,
      day: cModel.day,
      comment: cModel.comment,
      expense: cModel.amount,
    );

    await DBExpenses.db.updateExpense(expenses);
  }

  /* 
    ---- Functions to delete ----
  */

  deleteExpense(int id) async {
    await DBExpenses.db.deleteExpense(id);
    notifyListeners();
  }

  /* 
    ---- Getters to combined lists ----
  */

  List<CombinedModel> get allItemsList {
    List<CombinedModel> _cModel = [];

    for (var e in eList) {
      for (var f in fList) {
        if (e.link == f.id) {
          _cModel.add(
            CombinedModel(
              category: f.category,
              color: f.color,
              icon: f.icon,
              id: e.id,
              amount: e.expense,
              comment: e.comment,
              year: e.year,
              month: e.month,
              day: e.day,
            ),
          );
        }
      }
    }

    return cList = [..._cModel];
  }

  List<CombinedModel> get groupItemsList {
    List<CombinedModel> _cModel = [];

    for (var e in eList) {
      for (var f in fList) {
        if (e.link == f.id) {
          double _amount = eList
              .where((e) => e.link == f.id)
              .fold(0.0, (previousValue, e) => previousValue + e.expense);
          _cModel.add(
            CombinedModel(
              category: f.category,
              color: f.color,
              icon: f.icon,
              amount: _amount,
            ),
          );
        }
      }
    }

    var encode = _cModel.map((e) => jsonEncode(e));
    var unique = encode.toSet();
    var result = unique.map((e) => jsonDecode(e));
    _cModel = result.map((e) => CombinedModel.fromJson(e)).toList();

    return cList = [..._cModel];
  }
}
