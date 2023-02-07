import 'dart:ui' show Color;

enum CenterVerticalPosition { TOP, CENTER, BOTTOM }

enum CenterHorizontalPosition { RIGHT, CENTER, LEFT }

class Background {
  static const List<String> centerVerticalLabels = ["Top", "Middle", "Bottom"];
  static const List<String> centerHorizontalLabels = [
    "Right",
    "Center",
    "Left"
  ];
  static const List<String> imageQualityLabels = [
    "Low",
    "Middle",
    "High",
    "Very High"
  ];
  static const List<int> imgDimensions = [32, 64, 128, 256];
  static const List<int> imgQuality = [0, 1, 2, 3];
  int height, width, imageQuality;
  Color color;
  CenterVerticalPosition centerVerticalPosition;
  CenterHorizontalPosition centerHorizontalPosition;
  bool isVortex;
  String? encodedBase64Img;

  Background(
      {required this.height,
      required this.width,
      required this.imageQuality,
      required this.color,
      required this.centerVerticalPosition,
      required this.centerHorizontalPosition,
      required this.isVortex,
      this.encodedBase64Img});

  void update({required Background newBackground}) {
    height = newBackground.height;
    width = newBackground.width;
    imageQuality = newBackground.imageQuality;
    color = newBackground.color;
    isVortex = newBackground.isVortex;
  }

  Map<String, dynamic> toMap() => {
        "height": height,
        "width": width,
        "neurons": imageQuality + 4,
        "red": color.red,
        "green": color.green,
        "blue": color.blue,
        "verticalPosition": centerVerticalPosition.index,
        "horizontalPosition": centerHorizontalPosition.index,
        "vortex": isVortex,
      };

  getImgFromJson({required Map<String, dynamic> json}) =>
      encodedBase64Img = json['img'];
}
