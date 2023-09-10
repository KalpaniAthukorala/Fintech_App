import 'package:flutter/material.dart';

class ExpenseForm extends StatefulWidget {
  @override
  _ExpenseFormState createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final TextEditingController expenseTypeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController howController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  // Define a function to create rounded input fields
  Widget _buildRoundedInputField(
      TextEditingController controller, String labelText) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildRoundedInputField(expenseTypeController, 'Expense Type'),
              _buildRoundedInputField(descriptionController, 'Description'),
              _buildRoundedInputField(amountController, 'Amount'),
              _buildRoundedInputField(howController, 'How (Income or Loan)'),
              _buildRoundedInputField(dateController, 'Date'),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Add code to save the data to the database
                  // You can use a database package like sqflite or Firebase Firestore
                  // Add your logic here
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    expenseTypeController.dispose();
    descriptionController.dispose();
    amountController.dispose();
    howController.dispose();
    dateController.dispose();
    super.dispose();
  }
}
