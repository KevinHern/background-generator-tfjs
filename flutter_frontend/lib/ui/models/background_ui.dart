// Basic Imports
import 'package:flutter/material.dart';

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
  bool isRGBInputColorWheelMode, isVortexMode;
  Color selectedColor;
  CenterVerticalPosition centerVerticalPosition;
  CenterHorizontalPosition centerHorizontalPosition;

  BackgroundFormUI()
      : selectedHeight = 1,
        selectedWidth = 1,
        selectedimageComplexity = 1,
        isRGBInputColorWheelMode = true,
        isVortexMode = true,
        hexColorInput = TextEditingController(),
        selectedColor = Colors.grey,
        centerVerticalPosition = CenterVerticalPosition.CENTER,
        centerHorizontalPosition = CenterHorizontalPosition.CENTER;

  // Methods
  void update() => notifyListeners();
}
