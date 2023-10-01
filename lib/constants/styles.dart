import 'package:flutter/material.dart';

import 'colors.dart';

const TextStyle descriptionStyle = TextStyle(
  fontSize: 12,
  color: bgBlack,
  fontWeight: FontWeight.w200,
);

const textInputDecoration = InputDecoration(
  hintText: "Email",
  hintStyle: TextStyle(color: mainBlue, fontSize: 15),
  fillColor: white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: mainYellow, width: 1),
    borderRadius: BorderRadius.all(
      Radius.circular(100),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: mainYellow, width: 1),
    borderRadius: BorderRadius.all(
      Radius.circular(100),
    ),
  ),
  // set text color to white
  labelStyle: TextStyle(color: Colors.white),
);
