import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter1/screens/income/IncomeListPage.dart'; // Update the import statement for the list page

class IncomeForm extends StatefulWidget {
  @override
  _IncomeFormState createState() => _IncomeFormState();
}

class _IncomeFormState extends State<IncomeForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  // Reference to Firestore collection (changed to 'incomes' collection)
  final CollectionReference incomesCollection = FirebaseFirestore.instance
      .collection('incomes'); // Update collection name

  // Define a function to create rounded input fields
  Widget _buildRoundedInputField(TextEditingController controller,
      String labelText, TextInputType inputType) {
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
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
        ),
      ),
    );
  }

  // Function to save income data to Firestore
  Future<String> _saveIncome() async {
    final incomeData = {
      'name': nameController.text,
      'description': descriptionController.text,
      'amount': int.tryParse(amountController.text) ?? 0,
      'date': dateController.text,
    };

    try {
      await incomesCollection.add(incomeData);
      // Successfully saved to Firestore
      return 'Income saved successfully'; // Return a success message
    } catch (e) {
      // Handle errors, e.g., show an error message
      print('Error saving income: $e');
      return 'Error saving income: $e'; // Return an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Income Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildRoundedInputField(
                  nameController, 'Name', TextInputType.text),
              _buildRoundedInputField(
                  descriptionController, 'Description', TextInputType.text),
              _buildRoundedInputField(
                  amountController, 'Amount', TextInputType.number),
              _buildRoundedInputField(
                  dateController, 'Date', TextInputType.text),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  String result = await _saveIncome();
                  print(result);

                  if (result == 'Income saved successfully') {
                    // Navigate to the new page with the saved data
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => IncomeListPage({
                          'name': nameController.text,
                          'description': descriptionController.text,
                          'amount': int.tryParse(amountController.text) ?? 0,
                          'date': dateController.text,
                        }),
                      ),
                    );
                  }

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Income Save Result'),
                        content: Text(result),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
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
    nameController.dispose();
    descriptionController.dispose();
    amountController.dispose();
    dateController.dispose();
    super.dispose();
  }
}
