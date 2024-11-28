import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'budget_provider.dart';
import 'home_screen.dart';
import 'spending_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => BudgetProvider(),
      child: MaterialApp(
        title: 'Budget Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.black,
            secondary: Colors.amber,
            background: Colors.white,
          ),
          fontFamily: 'Montserrat',
          textTheme: TextTheme(
            headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
            bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black87),
          ),
        ),
        home: HomeScreen(),
        routes: {
          '/spending': (ctx) => SpendingScreen(),
        },
      ),
    );
  }
}
