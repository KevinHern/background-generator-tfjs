// Basic Imports
import 'package:flutter/material.dart';

// Models
import 'package:flutter_frontend/data/models/background.dart';

class BackgroundUI extends ChangeNotifier {
  Background _background;

  BackgroundUI({required Background background}) : _background = background;

  // Getters
  Background get background => _background;

  // Methods
  void update() => notifyListeners();
}

class BackgroundFormUI extends ChangeNotifier {
  final TextEditingController hexColorInput;
  int selectedHeight, selectedWidth, selectedImgQuality;
  bool isRGBInputColorWheelMode, isVortexMode;
  Color selectedColor;
  CenterVerticalPosition centerVerticalPosition;
  CenterHorizontalPosition centerHorizontalPosition;

  BackgroundFormUI()
      : selectedHeight = 0,
        selectedWidth = 0,
        selectedImgQuality = 1,
        isRGBInputColorWheelMode = true,
        isVortexMode = true,
        hexColorInput = TextEditingController(),
        selectedColor = Colors.grey,
        centerVerticalPosition = CenterVerticalPosition.CENTER,
        centerHorizontalPosition = CenterHorizontalPosition.CENTER;

  // Methods
  void update() => notifyListeners();
}
