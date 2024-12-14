import 'package:flutter/material.dart';

class BudgetSimulator extends StatefulWidget {
  @override
  _BudgetSimulatorState createState() => _BudgetSimulatorState();
}

class _BudgetSimulatorState extends State<BudgetSimulator> {
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _rentController = TextEditingController();
  final TextEditingController _foodController = TextEditingController();
  final TextEditingController _transportController = TextEditingController();
  final TextEditingController _entertainmentController = TextEditingController(); // Nouveau champ

  double _totalExpenses = 0.0;
  double _remainingBalance = 0.0;
  String _message = '';

  void _calculateExpenses() {
    final double rent = double.tryParse(_rentController.text) ?? 0.0;
    final double food = double.tryParse(_foodController.text) ?? 0.0;
    final double transport = double.tryParse(_transportController.text) ?? 0.0;
    final double entertainment = double.tryParse(_entertainmentController.text) ?? 0.0; // Nouveau calcul

    setState(() {
      _totalExpenses = rent + food + transport + entertainment;
    });
  }

  void _calculateBalance() {
    final double income = double.tryParse(_incomeController.text) ?? 0.0;

    setState(() {
      _remainingBalance = income - _totalExpenses;

      if (_remainingBalance > 0) {
        _message = 'Économies possibles';
      } else {
        _message = 'Attention aux dépenses !';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simulateur de budget mensuel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _incomeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Revenus mensuels'),
              ),

              






              SizedBox(height: 20),
              TextField(
                controller: _rentController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Loyer'),
              ),
              TextField(
                controller: _foodController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Alimentation'),
              ),
              TextField(
                controller: _transportController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Transport'),
              ),
              TextField(
                controller: _entertainmentController, // Nouveau champ
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Autres'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateExpenses,
                child: Text('Calculer les dépenses'),
              ),
              SizedBox(height: 10),
              Text(
                'Total des dépenses : ${_totalExpenses.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateBalance,
                child: Text('Calculer le solde restant'),
              ),
              SizedBox(height: 10),
              Text(
                'Solde restant : ${_remainingBalance.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                _message,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _remainingBalance > 0 ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
