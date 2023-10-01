import 'package:flutter/material.dart';
import 'package:flutter1/screens/home/Home.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MaterialApp(home: ProfilePage()));
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? image;
  String? userName;
  String? userEmail;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch user information when the profile page is loaded
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      // Get the current authenticated user
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Get the user's email and display name
        setState(() {
          userName = user.displayName;
          userEmail = user.email;
        });

        // Set the initial values for name and email controllers
        nameController.text = userName ?? "";
        emailController.text = userEmail ?? "";
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  Future pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;
      final imageTemp = File(pickedImage.path);
      setState(() => image = imageTemp);
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> updateProfile() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Update user profile information
        await user.updateProfile(displayName: nameController.text);

        // Update user email if it has changed
        if (userEmail != emailController.text) {
          await user.updateEmail(emailController.text);
        }

        // Display the updated display name and email
        setState(() {
          userName = user.displayName;
          userEmail = user.email;
        });

        // Show a success message using a SnackBar
        final snackBar = SnackBar(
          content: Text('Profile updated successfully!'),
          duration: Duration(seconds: 2), // Adjust the duration as needed
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        // Handle the image upload and update in your database here
        // You can use the `image` variable to upload the profile image
      }
    } catch (e) {
      print('Error updating profile: $e');
      // Show an error message using a SnackBar
      final snackBar = SnackBar(
        content: Text('Error updating profile. Please try again later.'),
        duration: Duration(seconds: 2), // Adjust the duration as needed
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Add a back button icon
          onPressed: () {
            // Navigate directly to the home page without a back navigation
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Home()), // Replace 'Home()' with your home page widget
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            // Display the user's profile image
            image != null
                ? CircleAvatar(
                    radius: 80,
                    backgroundImage: FileImage(image!),
                  )
                : CircleAvatar(
                    radius: 80,
                    // You can use a placeholder image here
                    backgroundImage: AssetImage('assets/placeholder.png'),
                  ),
            SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: emailController,
              style: TextStyle(fontSize: 16, color: Colors.grey),
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  color: Colors.blue,
                  child: const Text(
                    "Pick from Gallery",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  },
                ),
                SizedBox(width: 20),
                MaterialButton(
                  color: Colors.blue,
                  child: const Text(
                    "Capture from Camera",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                updateProfile();
              },
              child: const Text(
                "Update Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
