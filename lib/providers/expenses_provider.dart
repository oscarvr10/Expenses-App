import 'dart:convert';

import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/models/entries_model.dart';
import 'package:exp_app/models/expenses_model.dart';
import 'package:exp_app/models/features_model.dart';
import 'package:exp_app/providers/db_expenses.dart';
import 'package:exp_app/providers/db_features.dart';
import 'package:flutter/material.dart';

class ExpensesProvider extends ChangeNotifier {
  List<FeaturesModel> fList = [];
  List<ExpensesModel> eList = [];
  List<CombinedModel> cList = [];
  List<EntriesModel> etList = [];

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

  addNewEntry(CombinedModel cModel) async {
    var entries = EntriesModel(
      year: cModel.year,
      month: cModel.month,
      day: cModel.day,
      comment: cModel.comment,
      entries: cModel.amount,
    );

    final id = await DBExpenses.db.addNewEntry(entries);
    entries.id = id;

    etList.add(entries);
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

  getEntriesByDate(int month, int year) async {
    final response = await DBExpenses.db.getEntriesByDate(month, year);

    etList = [...response];
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

  updateEntry(CombinedModel cModel) async {
    var entries = EntriesModel(
      id: cModel.id,
      year: cModel.year,
      month: cModel.month,
      day: cModel.day,
      comment: cModel.comment,
      entries: cModel.amount,
    );

    await DBExpenses.db.updateEntry(entries);
  }

  /* 
    ---- Functions to delete ----
  */

  deleteExpense(int id) async {
    await DBExpenses.db.deleteExpense(id);
    notifyListeners();
  }

  deleteEntry(int id) async {
    await DBExpenses.db.deleteEntry(id);
    notifyListeners();
  }

  /* 
    ---- Getters to combined lists ----
  */

  List<CombinedModel> get allExpensesList {
    List<CombinedModel> cModel = [];

    for (var e in eList) {
      for (var f in fList) {
        if (e.link == f.id) {
          cModel.add(
            CombinedModel(
              category: f.category,
              color: f.color,
              icon: f.icon,
              link: e.link,
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

    return cList = [...cModel];
  }

  List<CombinedModel> get allEntriesList {
    List<CombinedModel> etModel = [];

    for (var et in etList) {
      etModel.add(
        CombinedModel(
          id: et.id,
          amount: et.entries,
          comment: et.comment,
          year: et.year,
          month: et.month,
          day: et.day,
        ),
      );
    }

    return cList = [...etModel];
  }

  List<CombinedModel> get groupExpensesList {
    List<CombinedModel> cModel = [];

    for (var e in eList) {
      for (var f in fList) {
        if (e.link == f.id) {
          double amount = eList
              .where((e) => e.link == f.id)
              .fold(0.0, (previousValue, e) => previousValue + e.expense);
          cModel.add(
            CombinedModel(
              category: f.category,
              color: f.color,
              icon: f.icon,
              amount: amount,
            ),
          );
        }
      }
    }

    var encode = cModel.map((e) => jsonEncode(e));
    var unique = encode.toSet();
    var result = unique.map((e) => jsonDecode(e));
    cModel = result.map((e) => CombinedModel.fromJson(e)).toList();

    return cList = [...cModel];
  }
}
