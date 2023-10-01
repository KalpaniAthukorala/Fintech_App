import 'package:flutter/material.dart';
import 'package:flutter1/constants/colors.dart';
import 'package:flutter1/constants/Description.dart';
import 'package:flutter1/constants/Styles.dart';

import '../../services/auth.dart';

// ignore: camel_case_types
class Sign_In extends StatefulWidget {
  //function
  final Function toggle;
  const Sign_In({Key? key, required this.toggle}) : super(key: key);

  @override
  State<Sign_In> createState() => _Sign_InState();
}

// ignore: camel_case_types
class _Sign_InState extends State<Sign_In> {
  // Refactor the AuthServices class to AuthServices
  final AuthServices _auth = AuthServices();

//_formKey
  final _formKey = GlobalKey<FormState>();
  //email password states
  String email = "";
  String password = "";
  String error = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text("SIGN IN"),
        elevation: 0,
        backgroundColor: mainBlue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 10),
          child: Column(
            children: [
              //descrption
              const Text(
                description,
                style: descriptionStyle,
              ),

              Center(
                child: Image.asset(
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
                      //email
                      TextFormField(
                        style: TextStyle(color: Colors.black),
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

                      //password
                      TextFormField(
                        obscureText: true,
                        style: TextStyle(color: Colors.black),
                        decoration:
                            textInputDecoration.copyWith(hintText: "password"),
                        validator: (val) => val!.length < 6
                            ? "Password must be at least 6 characters"
                            : null,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      Text(
                        error,
                        style: TextStyle(color: Colors.red),
                      ),
                      //google
                      const SizedBox(height: 20),
                      const Text(
                        login_social,
                        style: descriptionStyle,
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        //sing in with google
                        onTap: () {},
                        child: Center(
                          child: Image.asset(
                            'assets/images/google.png',
                            height: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      //register
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
                            //go to the register page

                            onTap: () {
                              widget.toggle();
                            },

                            child: const Text(
                              "REGISTER",
                              style: TextStyle(
                                  color: mainBlue, fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),

                      //button
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        //methode for login user
                        onTap: () async {
                          dynamic result = await _auth
                              .signInUsingEmailAndPassword(email, password);

                          if (result == null) {
                            setState(() {
                              error = "Could not signin with those credentials";
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
                            "LOGIN",
                            style: TextStyle(
                                color: mainBlue, fontWeight: FontWeight.w500),
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      //anon
                      GestureDetector(
                        //methode for login user as anon
                        onTap: () async {
                          await _auth.signInAnonymously();
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
                              "LOGIN AS GUEST",
                              style: TextStyle(
                                  color: mainBlue, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
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
