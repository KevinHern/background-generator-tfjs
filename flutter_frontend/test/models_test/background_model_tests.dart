// Basic Imports
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Models
import 'package:flutter_frontend/data/models/background.dart';

void main() {
  group(
    "Background Model Tests",
    () {
      test(
        "Should return a Map<String, dynamic> when 'toMap' is called on a Background Model",
        () {
          // Prepare Data
          final Background background = Background(
            height: 10,
            width: 10,
            imageComplexity: 10,
            color: Colors.white,
            centerVerticalPosition: CenterVerticalPosition.CENTER,
            centerHorizontalPosition: CenterHorizontalPosition.CENTER,
            isVortex: true,
          );
          final Map<String, dynamic> expectedResult = {
            "height": 10,
            "width": 10,
            "neurons": 11,
            "red": 255,
            "green": 255,
            "blue": 255,
            "centerPosition": 5,
            "vortex": true,
          };

          // Test
          final Map<String, dynamic> result = background.toMap();

          // Evaluate
          expect(result, expectedResult);
        },
      );

      test(
        "Should update a old Background Model with the new Background Model's values",
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

          // Test
          oldBackground.update(newBackground: newBackground);

          // Evaluate
          expect(oldBackground, newBackground);
        },
      );
    },
  );
}
