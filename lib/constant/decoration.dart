import 'package:flutter/material.dart';

InputDecoration inputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BorderRadius.circular(24.0),
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BorderRadius.circular(24.0),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
    borderRadius: BorderRadius.circular(24.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BorderRadius.circular(24.0),
  ),
);

// varible for the shadow
var _opacity = 0.1;
var _xOffset = 0.0;
var _yOffset = 0.0;
var _blurRadius = 8.0;
var _spreadRadius = 2.0;
// Shadow decoration
BoxShadow shadow = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, _opacity),
  offset: Offset(_yOffset, _xOffset),
  blurRadius: _blurRadius,
  spreadRadius: _spreadRadius,
);
