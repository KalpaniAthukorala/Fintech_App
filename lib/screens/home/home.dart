import 'package:flutter/material.dart';
import 'package:flutter1/screens/expenses/ExpensesListScreen.dart';
import 'package:flutter1/screens/expenses/Expense_form.dart';
import 'package:flutter1/screens/home/CustomCardWithImage.dart';
import 'package:flutter1/screens/home/GreetingCard.dart';
import 'package:flutter1/screens/home/SystemExplanationScreen.dart';
import 'package:flutter1/screens/income/IncomeListScreen.dart';
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

  void _navigateToExplanationPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SystemExplanationScreen()),
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
                    'Fintech Menu',
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
                    Navigator.pop(context); // Close the drawer
                    _navigateToIncomeForm(context); // Navigate to IncomeForm
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

                  // Add 6 custom cards
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IncomeListScreen(),
                            ),
                          );
                        },
                        child: CustomCardWithImage(
                          title: 'Income History',
                          subtitle: '',
                          imagePath: 'assets/images/income.jpeg',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExpensesListScreen(),
                            ),
                          );
                        },
                        child: CustomCardWithImage(
                          title: 'Expenses History',
                          subtitle: '',
                          imagePath: 'assets/images/expense.png',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(),
                            ),
                          );
                        },
                        child: CustomCardWithImage(
                          title: 'Profile',
                          subtitle: '',
                          imagePath: 'assets/images/man.png',
                        ),
                      ),
                    ],
                  ),

                  // ... Add any additional widgets or cards as needed.
                ],
              ),
              // Second Tab (Profile)
              ProfilePage(), // Display the ProfilePage as a tab
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _navigateToExplanationPage(context);
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.message),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.attach_money),
                label: 'Income',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.money_off),
                label: 'Expenses',
              ),
            ],
            onTap: (index) {
              if (index == 0) {
                // Navigate to the Income screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        IncomeForm(), // Change to the Income screen widget
                  ),
                );
              } else if (index == 1) {
                // Navigate to the Expenses screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ExpenseForm(), // Change to the Expenses screen widget
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
