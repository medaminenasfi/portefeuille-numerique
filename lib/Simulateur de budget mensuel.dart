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
  final TextEditingController _entertainmentController = TextEditingController();

  double _totalExpenses = 0.0;
  double _remainingBalance = 0.0;
  String _message = '';

  void _calculateExpenses() {
    final double rent = double.tryParse(_rentController.text) ?? 0.0;
    final double food = double.tryParse(_foodController.text) ?? 0.0;
    final double transport = double.tryParse(_transportController.text) ?? 0.0;
    final double entertainment = double.tryParse(_entertainmentController.text) ?? 0.0;

    setState(() {
      _totalExpenses = rent + food + transport + entertainment;
    });
  }

  void _calculateBalance() {
    final double income = double.tryParse(_incomeController.text) ?? 0.0;

    setState(() {
      _remainingBalance = income - _totalExpenses;

      if (_remainingBalance > 0) {
        _message = 'Excellent! Vous pouvez épargner';
      } else if (_remainingBalance == 0) {
        _message = 'Budget équilibré';
      } else {
        _message = 'Attention! Vous dépassez votre budget';
      }
    });
  }

  void _resetAll() {
    setState(() {
      _incomeController.clear();
      _rentController.clear();
      _foodController.clear();
      _transportController.clear();
      _entertainmentController.clear();
      _totalExpenses = 0.0;
      _remainingBalance = 0.0;
      _message = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Simulateur de Budget',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[700],
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetAll,
            tooltip: 'Réinitialiser',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue[50]!,
              Colors.grey[50]!,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                _buildHeaderSection(),
                SizedBox(height: 30),

                // Income Card
                _buildInputCard(
                  icon: Icons.attach_money_rounded,
                  title: 'Revenus Mensuels',
                  controller: _incomeController,
                  hintText: 'Entrez votre revenu total',
                  color: Colors.green,
                ),
                SizedBox(height: 20),

                // Expenses Section
                _buildExpensesSection(),
                SizedBox(height: 30),

                // Action Buttons
                _buildActionButtons(),
                SizedBox(height: 30),

                // Results Section
                _buildResultsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.blue[700]!, Colors.blue[600]!],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(Icons.pie_chart_rounded, color: Colors.white, size: 40),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Simulateur de Budget',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Planifiez vos finances mensuelles',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputCard({
    required IconData icon,
    required String title,
    required TextEditingController controller,
    required String hintText,
    required Color color,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            TextField(
              controller: controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: hintText,
                prefixText: '€ ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: color),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpensesSection() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.list_alt_rounded, color: Colors.orange),
                SizedBox(width: 12),
                Text(
                  'Dépenses Mensuelles',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildExpenseRow('🏠 Loyer', _rentController, Colors.orange),
            SizedBox(height: 12),
            _buildExpenseRow('🛒 Alimentation', _foodController, Colors.green),
            SizedBox(height: 12),
            _buildExpenseRow('🚗 Transport', _transportController, Colors.blue),
            SizedBox(height: 12),
            _buildExpenseRow('🎯 Autres Dépenses', _entertainmentController, Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseRow(String label, TextEditingController controller, Color color) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          flex: 3,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              prefixText: '€ ',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: color),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _calculateExpenses,
            icon: Icon(Icons.calculate_rounded),
            label: Text('Calculer Dépenses'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _calculateBalance,
            icon: Icon(Icons.balance_rounded),
            label: Text('Calculer Solde'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultsSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey[50]!,
              Colors.grey[100]!,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            // Total Expenses
            _buildResultItem(
              'Total des Dépenses',
              _totalExpenses.toStringAsFixed(2),
              Icons.money_off_rounded,
              Colors.red,
            ),
            SizedBox(height: 16),

            // Remaining Balance
            _buildResultItem(
              'Solde Restant',
              _remainingBalance.toStringAsFixed(2),
              _remainingBalance >= 0 ? Icons.trending_up_rounded : Icons.trending_down_rounded,
              _remainingBalance >= 0 ? Colors.green : Colors.red,
            ),
            SizedBox(height: 20),

            // Message
            if (_message.isNotEmpty)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _remainingBalance > 0
                      ? Colors.green.withOpacity(0.1)
                      : _remainingBalance == 0
                      ? Colors.blue.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _remainingBalance > 0
                        ? Colors.green
                        : _remainingBalance == 0
                        ? Colors.blue
                        : Colors.red,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _remainingBalance > 0
                          ? Icons.check_circle_rounded
                          : _remainingBalance == 0
                          ? Icons.info_rounded
                          : Icons.warning_rounded,
                      color: _remainingBalance > 0
                          ? Colors.green
                          : _remainingBalance == 0
                          ? Colors.blue
                          : Colors.red,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _message,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: _remainingBalance > 0
                              ? Colors.green[800]
                              : _remainingBalance == 0
                              ? Colors.blue[800]
                              : Colors.red[800],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultItem(String title, String value, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
        ),
        Text(
          '€ $value',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: color,
          ),
        ),
      ],
    );
  }
}