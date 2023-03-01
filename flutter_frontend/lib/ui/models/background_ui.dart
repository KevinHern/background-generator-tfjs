// Basic Imports
import 'package:flutter/material.dart';
import 'dart:async' show Timer;

// Models
import 'package:flutter_frontend/data/models/background.dart';

class BackgroundUI extends ChangeNotifier {
  Background? _background;

  BackgroundUI({Background? background}) : _background = background;

  // Setters
  set background(value) {
    _background = value;
    notifyListeners();
  }

  // Getters
  Background? get background => _background;

  // Methods
  void update() => notifyListeners();
}

class BackgroundFormUI extends ChangeNotifier {
  final TextEditingController hexColorInput;
  int selectedHeight, selectedWidth, selectedimageComplexity;
  bool isRGBInputColorWheelMode, isVortexMode, autoGenerate;
  Color selectedColor;
  CenterVerticalPosition centerVerticalPosition;
  CenterHorizontalPosition centerHorizontalPosition;
  Timer? timer;

  BackgroundFormUI()
      : selectedHeight = 1,
        selectedWidth = 1,
        selectedimageComplexity = 1,
        isRGBInputColorWheelMode = true,
        isVortexMode = true,
        autoGenerate = false,
        hexColorInput = TextEditingController(),
        selectedColor = const Color(0xFFDDDDDD),
        centerVerticalPosition = CenterVerticalPosition.CENTER,
        centerHorizontalPosition = CenterHorizontalPosition.CENTER;

  // Methods
  void update() => notifyListeners();
}
