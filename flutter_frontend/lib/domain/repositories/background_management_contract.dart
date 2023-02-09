// Basic Imports
import 'dart:ui';

// Models
import 'package:flutter_frontend/data/models/background.dart';

/// Here is found the definition of the contract of BackgroundManagement
abstract class BackgroundManagementRepository {
  Background createBackground({
    required int selectedHeight,
    required int selectedWidth,
    required Color color,
    required CenterHorizontalPosition centerHorizontalPosition,
    required CenterVerticalPosition centerVerticalPosition,
    required bool isVortex,
    required int imageQuality,
  });
  void updateBackground(
      {required Background newBackground, required Background oldBackground});
}
