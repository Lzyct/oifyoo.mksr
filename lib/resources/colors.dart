import 'package:flutter/material.dart';

// 100% — FF  ##  50% — 80
// 99% — FC   ## 49% — 7D
// 98% — FA   ## 48% — 7A
// 97% — F7   ## 47% — 78
// 96% — F5   ## 46% — 75
// 95% — F2   ## 45% — 73
// 94% — F0   ## 44% — 70
// 93% — ED   ## 43% — 6E
// 92% — EB   ## 42% — 6B
// 91% — E8   ## 41% — 69
// 90% — E6   ## 40% — 66
// 89% — E3   ## 39% — 63
// 88% — E0   ## 38% — 61
// 87% — DE   ## 37% — 5E
// 86% — DB   ## 36% — 5C
// 85% — D9   ## 35% — 59
// 84% — D6   ## 34% — 57
// 83% — D4   ## 33% — 54
// 82% — D1   ## 32% — 52
// 81% — CF   ## 31% — 4F
// 80% — CC   ## 30% — 4D
// 79% — C9   ## 29% — 4A
// 78% — C7   ## 28% — 47
// 77% — C4   ## 27% — 45
// 76% — C2   ## 26% — 42
// 75% — BF   ## 25% — 40
// 74% — BD   ## 24% — 3D
// 73% — BA   ## 23% — 3B
// 72% — B8   ## 22% — 38
// 71% — B5   ## 21% — 36
// 70% — B3   ## 20% — 33
// 69% — B0   ## 19% — 30
// 68% — AD   ## 18% — 2E
// 67% — AB   ## 17% — 2B
// 66% — A8   ## 16% — 29
// 65% — A6   ## 15% — 26
// 64% — A3   ## 14% — 24
// 63% — A1   ## 13% — 21
// 62% — 9E   ## 12% — 1F
// 61% — 9C   ## 11% — 1C
// 60% — 99   ## 10% — 1A
// 59% — 96   ## 9% — 17
// 58% — 94   ## 8% — 14
// 57% — 91   ## 7% — 12
// 56% — 8F   ## 6% — 0F
// 55% — 8C   ## 5% — 0D
// 54% — 8A   ## 4% — 0A
// 53% — 87   ## 3% — 08
// 52% — 85   ## 2% — 05
// 51% — 82   ## 1% — 03

class Palette {
  static Color colorPrimary = Color(0xffFFAA01);
  static Color colorPrimaryDark = Color(0xffFFAA01);
  static Color colorAccent = Color(0xffFED569);
  static Color colorBackground = Color(0xffffffff);
  static Color colorBackgroundAlt = Color(0xffF6F7F9);
  static Color colorText = Color(0xff4A2600);
  static Color colorHint = Color(0xCC5E748A);
  static Color colorHintSoft = Color(0x1A5E748A);
  static Color colorHintAlt = Color(0xFF5E748A);
  static Color colorLink = Color(0xFF2546F2);
  static Color blue = Color(0xFF065EEA);
  static Color blueSoft = Color(0xFFE7EFFD);
  static Color borderTextF = Color(0xFFC0C3DF);
  static Color toolTip = Color(0x80D8E9FF);
  static Color red = Color(0xFFFF005B);
  static Color redSoft = Color(0x1AFF005B);
  static Color unSelectedTab = Color(0xFF8D8DAB);
  static Color green = Color(0xFF2ED573);
  static Color greenAlt = Color(0xff1BB512);
  static Color greenAltSoft = Color(0x1A1BB512);
  static Color colorSelected = Color(0xFFC5A37E);
  static Color divider = Color(0xCCCFD6DC);
  static Color bottomIndicator = Color(0xFFE8E8E8);
}

ThemeData themeDefault = ThemeData(
  fontFamily: 'Poppins',
  backgroundColor: Palette.colorBackgroundAlt,
  primaryColor: Palette.colorPrimary,
  accentColor: Palette.colorAccent,
  textSelectionTheme: TextSelectionThemeData(cursorColor: Palette.colorAccent),
  textTheme: TextTheme(
    bodyText1: TextStyle(),
    bodyText2: TextStyle(),
  ).apply(
    bodyColor: Palette.colorText,
    displayColor: Palette.colorText,
  ),
  scaffoldBackgroundColor: Palette.colorBackground,
  iconTheme: IconThemeData(color: Colors.black),
  appBarTheme: AppBarTheme(
    elevation: 10,
    brightness: Brightness.dark,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
