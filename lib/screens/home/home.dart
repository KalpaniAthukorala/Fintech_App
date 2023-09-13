import 'package:flutter/material.dart';
import 'package:flutter1/screens/expenses/expense_form.dart';
import 'package:flutter1/screens/expenses/expense_service.dart';
import 'package:flutter1/services/auth.dart';
// Import the expense_service.dart file

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthServices _auth = AuthServices();

  void _navigateToExpenseForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ExpenseForm()),
    );
  }

  // Add a function to determine if it's morning or evening and get the day
  String _getGreeting() {
    final hour = DateTime.now().hour;
    final day = DateTime.now().toLocal().weekday;

    String greeting = '';
    if (hour < 12) {
      greeting = 'Good Morning';
    } else if (hour < 17) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }

    switch (day) {
      case DateTime.monday:
        return '$greeting, Monday';
      case DateTime.tuesday:
        return '$greeting, Tuesday';
      case DateTime.wednesday:
        return '$greeting, Wednesday';
      case DateTime.thursday:
        return '$greeting, Thursday';
      case DateTime.friday:
        return '$greeting, Friday';
      case DateTime.saturday:
        return '$greeting, Saturday';
      case DateTime.sunday:
        return '$greeting, Sunday';
      default:
        return greeting;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            ElevatedButton(
              style: const ButtonStyle(),
              onPressed: () async {
                await _auth.signOut();
              },
              child: const Icon(Icons.logout),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Add a card at the top with the greeting message
              Card(
                elevation: 4.0,
                margin: const EdgeInsets.only(bottom: 20.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _getGreeting(),
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Add a row for total balance, total income, and total expenses
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Total Balance
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Balance',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        '\$1000.00', // Replace with your total balance value
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // Total Income
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Income',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        '\$500.00', // Replace with your total income value
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // Total Expenses
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Expenses',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        '\$500.00', // Replace with your total expenses value
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Add a section to display expenses
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
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
                              // Customize how you display each expense card here
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _navigateToExpenseForm(context);
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
