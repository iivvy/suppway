import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LinearGradienClor {}

Gradient colorGradient(bool _theme) {
  return LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      _theme ? Colors.indigo.shade100 : Colors.white,
      _theme ? Colors.indigo.shade100 : const Color.fromRGBO(41, 70, 181, 1.0),
      _theme ? Colors.black : const Color.fromRGBO(41, 70, 181, 0.7),
    ],
  );
}
