import 'dart:ui' show Color;

import 'package:equatable/equatable.dart';

enum CenterVerticalPosition { TOP, CENTER, BOTTOM }

enum CenterHorizontalPosition { LEFT, CENTER, RIGHT }

class Background extends Equatable {
  static const List<String> centerVerticalLabels = ["Top", "Middle", "Bottom"];
  static const List<String> centerHorizontalLabels = [
    "Left",
    "Center",
    "Right"
  ];
  static const List<String> imageQualityLabels = [
    "Low",
    "Middle",
    "High",
    "Very High"
  ];
  static const List<int> imgDimensions = [32, 64, 128, 256, 512];
  static const List<int> imgComplexity = [0, 1, 2, 3];
  int height, width, imageComplexity;
  Color color;
  CenterVerticalPosition centerVerticalPosition;
  CenterHorizontalPosition centerHorizontalPosition;
  bool isVortex;
  String? encodedBase64Img;

  Background(
      {required this.height,
      required this.width,
      required this.imageComplexity,
      required this.color,
      required this.centerVerticalPosition,
      required this.centerHorizontalPosition,
      required this.isVortex,
      this.encodedBase64Img});

  void update({required Background newBackground}) {
    height = newBackground.height;
    width = newBackground.width;
    imageComplexity = newBackground.imageComplexity;
    color = newBackground.color;
    centerVerticalPosition = newBackground.centerVerticalPosition;
    centerHorizontalPosition = newBackground.centerHorizontalPosition;
    isVortex = newBackground.isVortex;
  }

  Map<String, dynamic> toMap() => {
        "height": height,
        "width": width,
        "neurons": imageComplexity + 1,
        "red": color.red,
        "green": color.green,
        "blue": color.blue,
        "centerPosition": (centerVerticalPosition.index * 3) +
            centerHorizontalPosition.index +
            1,
        "vortex": isVortex,
      };

  getImgFromJson({required Map<String, dynamic> json}) =>
      encodedBase64Img = json['image'];

  @override
  List<Object?> get props => [
        height,
        width,
        imageComplexity,
        color,
        centerVerticalPosition,
        centerHorizontalPosition,
        isVortex
      ];
}
