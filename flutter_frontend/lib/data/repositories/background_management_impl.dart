// Basic Imports
import 'dart:ui';

// Models
import 'package:flutter_frontend/data/models/background.dart';

// Repositories
import 'package:flutter_frontend/domain/repositories/background_management_contract.dart';

/// Here is found the definition of the contract of BackgroundManagement
class BackgroundManagementImpl implements BackgroundManagementRepository {
  @override
  Background createBackground({
    required int selectedHeight,
    required int selectedWidth,
    required Color color,
    required CenterHorizontalPosition centerHorizontalPosition,
    required CenterVerticalPosition centerVerticalPosition,
    required bool isVortex,
    required int imageComplexity,
  }) =>
      Background(
        height: Background.imgDimensions[selectedHeight],
        width: Background.imgDimensions[selectedWidth],
        color: color,
        centerHorizontalPosition: centerHorizontalPosition,
        centerVerticalPosition: centerVerticalPosition,
        isVortex: isVortex,
        imageComplexity: imageComplexity,
      );

  @override
  void updateBackground(
          {required Background newBackground,
          required Background oldBackground}) =>
      oldBackground.update(newBackground: newBackground);
}
