import 'package:flutter/material.dart';
import 'package:flutter1/screens/expenses/expense_form.dart';
import 'package:flutter1/screens/expenses/expense_service.dart';
import 'package:flutter1/screens/income/income_form.dart';
import 'package:flutter1/screens/profile/profilePage.dart';
import 'package:flutter1/services/auth.dart';

void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({Key? key});

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

  void _navigateToIncomeForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => IncomeForm()),
    );
  }

  void _navigateToProfilePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  }

  void _navigateToHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }

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
    String greeting = _getGreeting();

    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // Open the drawer
                },
              ),
            ),
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
          // Add the drawer
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                // Drawer header
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Drawer Header',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                // Drawer items
                ListTile(
                  title: Text('Home'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    _navigateToHomePage(context); // Navigate to ProfilePage
                  },
                ),
                ListTile(
                  title: Text('Expenses'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    _navigateToExpenseForm(context); // Navigate to ProfilePage
                  },
                ),
                ListTile(
                  title: Text('Income'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawers
                    _navigateToIncomeForm(context); // Navigate to ProfilePage
                  },
                ),
                // Add a ListTile for ProfilePage
                ListTile(
                  title: Text('Profile'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    _navigateToProfilePage(context); // Navigate to ProfilePage
                  },
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // First Tab (Home)
              Column(
                children: [
                  // Add the GreetingCard widget here
                  GreetingCard(
                    greeting,
                    width: screenWidth, // Pass the screen width
                  ),
                  const SizedBox(height: 20.0), // Add spacing

                  // Add a row for total balance, total income, and total expenses
                  Row(
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
                            '\$100055.00', // Replace with your total balance value
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
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
                  ),
                ],
              ),
              // Second Tab (Profile)
              ProfilePage(), // Display the ProfilePage as a tab
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _navigateToIncomeForm(context);
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

// Create a new GreetingCard widget
class GreetingCard extends StatelessWidget {
  final String greeting;
  final double width;

  GreetingCard(this.greeting, {required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // Set the width to match the screen width
      color: Colors.orange, // Change the background color
      padding: const EdgeInsets.all(16.0),
      child: Text(
        greeting,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Change the text color
        ),
      ),
    );
  }
}
