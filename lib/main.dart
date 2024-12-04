import 'package:flutter/material.dart';

void main() {
  runApp(PayrollCalculatorApp());
}

class PayrollCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payroll Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PayrollCalculator(),
    );
  }
}

class PayrollCalculator extends StatefulWidget {
  @override
  _PayrollCalculatorState createState() => _PayrollCalculatorState();
}

class _PayrollCalculatorState extends State<PayrollCalculator> {
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _hoursController = TextEditingController();
  double _taxRate = 0.2;
  double _netPay = 0;
  String _salaryType = 'Annual';

  void _calculateNetPay() {
    double salary = double.tryParse(_salaryController.text) ?? 0;
    double hours = double.tryParse(_hoursController.text) ?? 0;

    if (_salaryType == 'Hourly') {
      salary *= hours;
    }

    double tax = salary * _taxRate;
    setState(() {
      _netPay = salary - tax;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payroll Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _salaryController,
              decoration: InputDecoration(labelText: 'Salary (or hourly rate)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _hoursController,
              decoration: InputDecoration(labelText: 'Total Hours (if hourly)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _salaryType,
              items: ['Annual', 'Hourly']
                  .map((type) => DropdownMenuItem(
                child: Text(type),
                value: type,
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _salaryType = value!;
                });
              },
              decoration: InputDecoration(labelText: 'Salary Type'),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Tax Rate:'),
                Radio(
                  value: 0.1,
                  groupValue: _taxRate,
                  onChanged: (value) {
                    setState(() {
                      _taxRate = value as double;
                    });
                  },
                ),
                Text('10%'),
                Radio(
                  value: 0.2,
                  groupValue: _taxRate,
                  onChanged: (value) {
                    setState(() {
                      _taxRate = value as double;
                    });
                  },
                ),
                Text('20%'),
                Radio(
                  value: 0.3,
                  groupValue: _taxRate,
                  onChanged: (value) {
                    setState(() {
                      _taxRate = value as double;
                    });
                  },
                ),
                Text('30%'),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _calculateNetPay,
                child: Text('Calculate Net Pay'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text('Net Pay: \$${_netPay.toStringAsFixed(2)}'),
            ),
          ],
        ),
      ),
    );
  }
}
