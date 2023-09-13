import 'package:flutter/material.dart';

class ExpenseListPage extends StatelessWidget {
  final Map<String, dynamic> expenseData;

  ExpenseListPage(this.expenseData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(expenseData['name']),
                ),
                ListTile(
                  title: Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(expenseData['description']),
                ),
                ListTile(
                  title: Text(
                    'Amount',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('\$${expenseData['amount']}'),
                ),
                ListTile(
                  title: Text(
                    'Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(expenseData['date']),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the page for adding new expenses
          Navigator.of(context).pop();
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
