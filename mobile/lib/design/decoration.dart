import 'package:flutter/material.dart';

BoxDecoration containerDecoration() {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: [
        const Color.fromARGB(255, 240, 6, 84),
        Colors.purpleAccent,
        const Color.fromARGB(255, 13, 142, 207),
      ],
    ),
    borderRadius: BorderRadius.circular(15),
  );
}
