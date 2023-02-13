// Basic Imports
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Models
import 'package:flutter_frontend/data/models/background.dart';

// Repositories
import 'package:flutter_frontend/data/repositories/background_management_impl.dart';
import 'package:flutter_frontend/domain/repositories/background_management_contract.dart';

void main() {
  group(
    "Background Repository Tests",
    () {
      test(
        "Should create a new Background Model when 'createBackground' is called.",
        () {
          // Preparing Data
          const height = 3,
              width = 3,
              imageComplexity = 2,
              color = Colors.white,
              centerVerticalPosition = CenterVerticalPosition.CENTER,
              centerHorizontalPosition = CenterHorizontalPosition.CENTER,
              isVortex = true;

          Background expectedResult = Background(
              height: 256,
              width: 256,
              imageComplexity: imageComplexity,
              color: color,
              centerVerticalPosition: centerVerticalPosition,
              centerHorizontalPosition: centerHorizontalPosition,
              isVortex: isVortex);

          BackgroundManagementRepository backgroundManagementRepository =
              BackgroundManagementImpl();

          // Test
          final result = backgroundManagementRepository.createBackground(
            selectedHeight: height,
            selectedWidth: width,
            color: color,
            centerHorizontalPosition: centerHorizontalPosition,
            centerVerticalPosition: centerVerticalPosition,
            isVortex: isVortex,
            imageComplexity: imageComplexity,
          );

          // Evaluate
          expect(result, expectedResult);
        },
      );

      test(
        'Should update an old Background Model with the values of a new Background Model',
        () {
          // Prepare Data
          final Background oldBackground = Background(
            height: 10,
            width: 10,
            imageComplexity: 10,
            color: Colors.white,
            centerVerticalPosition: CenterVerticalPosition.CENTER,
            centerHorizontalPosition: CenterHorizontalPosition.CENTER,
            isVortex: true,
          );
          final Background newBackground = Background(
            height: 30,
            width: 30,
            imageComplexity: 50,
            color: Colors.blue,
            centerVerticalPosition: CenterVerticalPosition.TOP,
            centerHorizontalPosition: CenterHorizontalPosition.LEFT,
            isVortex: false,
          );

          BackgroundManagementRepository backgroundManagementRepository =
              BackgroundManagementImpl();

          // Test
          backgroundManagementRepository.updateBackground(
              newBackground: newBackground, oldBackground: oldBackground);

          // Evaluate
          expect(oldBackground, newBackground);
        },
      );
    },
  );
}
