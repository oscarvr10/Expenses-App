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

String getMonthName(int month) {
  Map<int, String> _monthsMap = {
    1: 'Enero',
    2: 'Febrero',
    3: 'Marzo',
    4: 'Abril',
    5: 'Mayo',
    6: 'Junio',
    7: 'Julio',
    8: 'Agosto',
    9: 'Septiembre',
    10: 'Octubre',
    11: 'Noviembre',
    12: 'Diciembre',
  };

  return _monthsMap[month]!;
}
