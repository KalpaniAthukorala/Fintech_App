import 'package:flutter/material.dart';
import 'package:flutter1/screens/expenses/expense_service.dart';

class IncomeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Income List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getExpenses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final incomeList = snapshot.data;
            return ListView.builder(
              itemCount: incomeList?.length,
              itemBuilder: (context, index) {
                final income = incomeList?[index];
                return Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text(income?['name']),
                    subtitle: Text(
                      'Amount: \$${income?['amount']}',
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
