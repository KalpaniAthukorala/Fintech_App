import 'package:flutter/material.dart';

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
