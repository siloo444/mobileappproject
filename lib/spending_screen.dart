import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'budget_provider.dart';
import 'package:fl_chart/fl_chart.dart';

class SpendingScreen extends StatefulWidget {
  @override
  _SpendingScreenState createState() => _SpendingScreenState();
}

class _SpendingScreenState extends State<SpendingScreen> {
  final Map<String, TextEditingController> _controllers = {
    'Taxes': TextEditingController(),
    'Insurance': TextEditingController(),
    'Food': TextEditingController(),
    'Savings': TextEditingController(),
    'Others': TextEditingController(),
  };

  bool _isDataEntered = false;

  void _checkDataEntered() {
    setState(() {
      _isDataEntered = _controllers.values.every((controller) => controller.text.isNotEmpty);
    });
  }

  @override
  Widget build(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Planner', style: TextStyle(color: Colors.amber, fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Center the text horizontally
            children: [
              Text(
                'Please enter your spendings below',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Your allowance for this month: \$${budgetProvider.monthlyAllowance}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _controllers.keys.length,
                itemBuilder: (ctx, index) {
                  String category = _controllers.keys.elementAt(index);
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: _controllers[category],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Enter amount for $category',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _checkDataEntered();
                        budgetProvider.setSpending(category, double.parse(value.isEmpty ? '0' : value));
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 20), // Space between text fields and pie chart
              if (_isDataEntered)
                Column(
                  children: [
                    Container(
                      height: 300,
                      child: PieChart(
                        PieChartData(
                          sections: budgetProvider.spending.entries.map((entry) {
                            return PieChartSectionData(
                              value: entry.value,
                              title: '${entry.key}',
                              titleStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black), // Bold text for pie chart labels
                              color: Colors.primaries[budgetProvider.spending.keys.toList().indexOf(entry.key) % Colors.primaries.length],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Total Spending: \$${budgetProvider.spending.values.reduce((a, b) => a + b).toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Text(
                      budgetProvider.spending.values.reduce((a, b) => a + b) > budgetProvider.monthlyAllowance
                          ? 'Over spent'
                          : 'Fairly spent',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }
}
