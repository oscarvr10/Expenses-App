// ignore: depend_on_referenced_packages
import 'package:exp_app/models/entries_model.dart';
import 'package:intl/intl.dart';

import '../models/expenses_model.dart';
export 'package:exp_app/utils/math_operations.dart';

getAmountFormat(double amount) {
  return NumberFormat.simpleCurrency().format(amount);
}

getTotalExpenses(List<ExpensesModel> expenses) {
  double _eList = expenses
      .map((e) => e.expense)
      .fold(0.0, (previousValue, element) => previousValue + element);

  return _eList;
}

getTotalEntries(List<EntriesModel> entries) {
  double _etList = entries
      .map((e) => e.entries)
      .fold(0.0, (previousValue, element) => previousValue + element);

  return _etList;
}

getBalance(List<ExpensesModel> expenses, List<EntriesModel> entries) {
  double _balance = getTotalEntries(entries) - getTotalExpenses(expenses);
  return getAmountFormat(_balance);
}
