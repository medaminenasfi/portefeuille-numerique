import 'package:flutter/material.dart';

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedCurrency = 'USD';
  double _result = 0.0;

  final Map<String, double> _exchangeRates = {
    'USD': 1.1,
    'EUR': 0.9,
    'TND': 3.0,
  };

  void _convert() {
    final double amount = double.tryParse(_amountController.text) ?? 0.0;
    setState(() {
      _result = amount * (_exchangeRates[_selectedCurrency] ?? 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Convertisseur de devise')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Montant à convertir',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCurrency,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCurrency = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Devise cible',
                  border: OutlineInputBorder(),
                ),
                items: _exchangeRates.keys.map<DropdownMenuItem<String>>(
                      (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _convert,
                child: Text('Convertir'),
              ),
              SizedBox(height: 20),
              Text(
                'Résultat : ${_result.toStringAsFixed(2)} $_selectedCurrency',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
