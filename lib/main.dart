import 'package:flutter/material.dart';
import '../view/securus_debit_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Securus Debit',
      theme: ThemeData(
        primaryColor: Color(0xFF4267B2),
        primarySwatch: Colors.blue,
      ),
      home: SecurusDebitScreen(),
    );
  }
}
