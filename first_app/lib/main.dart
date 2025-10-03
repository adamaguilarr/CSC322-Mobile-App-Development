import 'package:flutter/material.dart';
import 'package:first_app/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          Color.fromARGB(255, 37, 5, 92),
          Color.fromARGB(255, 77, 41, 138),
        ),
      ),
    ),
  );
}
