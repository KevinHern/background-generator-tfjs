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
    required int height,
    required int width,
    required Color color,
    required CenterHorizontalPosition centerHorizontalPosition,
    required CenterVerticalPosition centerVerticalPosition,
    required bool isVortex,
    required int imageQuality,
  }) =>
      Background(
        height: height,
        width: width,
        color: color,
        centerHorizontalPosition: centerHorizontalPosition,
        centerVerticalPosition: centerVerticalPosition,
        isVortex: isVortex,
        imageQuality: imageQuality,
      );

  @override
  void updateBackground(
          {required Background newBackground,
          required Background oldBackground}) =>
      oldBackground.update(newBackground: newBackground);
}
