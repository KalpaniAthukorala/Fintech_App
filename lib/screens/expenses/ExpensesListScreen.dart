import 'package:flutter/material.dart';
import 'package:flutter1/screens/expenses/expense_service.dart';

class ExpensesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getExpenses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final expenseList = snapshot.data;
            return ListView.builder(
              itemCount: expenseList?.length,
              itemBuilder: (context, index) {
                final expense = expenseList?[index];
                return Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text(expense?['name']),
                    subtitle: Text(
                      'Amount: \$${expense?['amount']}',
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
