// new_window.dart
import 'package:flutter/material.dart';

class NewWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Window'),
      ),
      body: Center(
        child: Text('This is a new window.'),
      ),
    );
  }
}
