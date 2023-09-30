import 'package:flutter/material.dart';

class SystemExplanationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('System Explanation'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Welcome to our System',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Our system is designed to help you manage your finances and expenses efficiently.',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          Image.asset(
            'assets/images/img1.png', // Replace with your image path
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Track Your Income',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'You can easily add and track your income sources. Our system provides detailed insights into your earnings.',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          Image.asset(
            'assets/images/img2.jpeg', // Replace with your image path
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Manage Your Expenses',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'You can categorize and track your expenses effortlessly. The system provides reports to help you understand your spending habits.',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          Image.asset(
            'assets/images/img3.jpeg', // Replace with your image path
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          // Continue adding text and images to explain your system further.
        ],
      ),
    );
  }
}
