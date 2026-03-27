import 'package:flutter/widgets.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockWidth;
  static late double blockHeight;

  static late double textMultiplier;
  static late double imageSizeMultiplier;
  static late double heightMultiplier;
  static late double widthMultiplier;

  // The base design size typically from Figma (width: 390, height: 844)
  static const double _baseScreenWidth = 390.0;
  static const double _baseScreenHeight = 844.0;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    // A block is 1% of the screen
    blockWidth = screenWidth / 100;
    blockHeight = screenHeight / 100;

    // Multipliers based on the base design
    widthMultiplier = screenWidth / _baseScreenWidth;
    heightMultiplier = screenHeight / _baseScreenHeight;

    // The multiplier used for text size scaling
    textMultiplier = widthMultiplier;
    
    // The multiplier used for image or border radius scaling
    imageSizeMultiplier = widthMultiplier;
  }
}
