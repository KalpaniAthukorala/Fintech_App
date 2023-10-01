import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter1/constants/colors.dart';
import 'package:flutter1/constants/Styles.dart';
import 'package:flutter1/services/auth.dart';
import 'package:flutter1/constants/Description.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  final Function toggle;
  const Register({Key? key, required this.toggle}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthServices _auth = AuthServices();

  // Form key
  final _formKey = GlobalKey<FormState>();
  // Email and password states
  String email = "";
  String password = "";
  String error = "";
  // Profile picture
  XFile? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text("REGISTER"),
        elevation: 0,
        backgroundColor: mainBlue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 10),
          child: Column(
            children: [
              // Description
              const Text(
                description,
                style: descriptionStyle,
              ),

              Center(
                child: imageFile != null
                    ? Image.file(File(imageFile!.path), height: 100)
                    : Image.asset(
                        'assets/images/man.png',
                        height: 100,
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: textInputDecoration,
                        validator: (val) =>
                            val!.isEmpty ? "Enter a valid email" : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      // Password
                      TextFormField(
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        decoration:
                            textInputDecoration.copyWith(hintText: "Password"),
                        validator: (val) => val!.length < 6
                            ? "Password must be at least 6 characters"
                            : null,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      // Google
                      const SizedBox(height: 20),
                      // Error text
                      Text(
                        error,
                        style: TextStyle(color: Colors.red),
                      ),
                      const Text(
                        "Login with social accounts",
                        style: descriptionStyle,
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        // Sign in with Google
                        onTap: () {},
                        child: Center(
                          child: Image.asset(
                            'assets/images/google.png',
                            height: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Register
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            login,
                            style: descriptionStyle,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            // Go to the signin page
                            onTap: () {
                              widget.toggle();
                            },
                            child: const Text(
                              "LOGIN",
                              style: TextStyle(
                                  color: mainBlue, fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),

                      // Button
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        // Method for registering user
                        onTap: () async {
                          // Select a profile picture
                          final pickedImage = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (pickedImage != null) {
                            setState(() {
                              imageFile = pickedImage;
                            });
                          }

                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);

                          if (result == null) {
                            // Error
                            setState(() {
                              error = "Please enter a valid email!";
                            });
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 2, color: mainYellow)),
                          child: const Center(
                              child: Text(
                            "REGISTER",
                            style: TextStyle(
                                color: mainBlue, fontWeight: FontWeight.w500),
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // Anon
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
