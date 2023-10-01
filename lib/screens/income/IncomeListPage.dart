import 'package:flutter/material.dart';

class IncomeListPage extends StatelessWidget {
  final Map<String, dynamic> incomeData; // Updated variable name

  IncomeListPage(this.incomeData); // Updated constructor parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Income Details'), // Updated title
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
                  subtitle: Text(incomeData['name']), // Updated label
                ),
                ListTile(
                  title: Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(incomeData['description']), // Updated label
                ),
                ListTile(
                  title: Text(
                    'Amount',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('\Rs${incomeData['amount']}'), // Updated label
                ),
                ListTile(
                  title: Text(
                    'Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(incomeData['date']), // Updated label
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the previous page
          Navigator.of(context).pop();
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
