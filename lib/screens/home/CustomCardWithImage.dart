import 'package:flutter/material.dart';

class CustomCardWithImage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  CustomCardWithImage({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment
              .center, // Align elements vertically in the center
          children: [
            Image.asset(
              imagePath,
              height: 100,
              width: 100, // Specify a fixed width for the image
            ),
            SizedBox(width: 16.0), // Add spacing between image and text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0, // Customize the text style as needed
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
