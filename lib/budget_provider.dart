import 'package:flutter/material.dart';

class BudgetProvider with ChangeNotifier {
  double monthlyAllowance = 0.0;
  Map<String, double> spending = {
    'Taxes': 0.0,
    'Insurance': 0.0,
    'Food': 0.0,
    'Savings': 0.0,
    'Others': 0.0,
  };

  void setMonthlyAllowance(double value) {
    monthlyAllowance = value;
    notifyListeners();
  }

  void setSpending(String category, double value) {
    spending[category] = value;
    notifyListeners();
  }
}
