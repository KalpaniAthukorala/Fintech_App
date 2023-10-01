import 'package:flutter/material.dart';

// Create a CustomCard widget for your custom cards
class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;

  CustomCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(12.0), // Adjust the corner radius as needed
      ),
      color: Colors.blue, // Set the background color to blue
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
      ),
    );
  }
}
