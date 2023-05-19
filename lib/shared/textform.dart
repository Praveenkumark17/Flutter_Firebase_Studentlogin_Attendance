import 'package:flutter/material.dart';

final inputformdecoration = InputDecoration(
  fillColor: Colors.amber[50],
  filled: true,
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.amber,
      width: 2.0,
    ),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.amber,
      width: 2.0,
    ),
  ),
  focusedErrorBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.amber,
      width: 2.0,
    ),
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      color: Color.fromARGB(255, 255, 0, 0),
      width: 2.0,
    ),
  ),
  labelStyle: const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
  ),
);
