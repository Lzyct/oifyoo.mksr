import 'package:flutter/material.dart';
import 'package:oifyoo_mksr/resources/resources.dart';

import 'colors.dart';

class TextStyles {
  static TextStyle primaryBold = TextStyle(
    fontSize: Dimens.fontNormal,
    fontWeight: FontWeight.bold,
    color: Palette.colorPrimary,
  );
  static TextStyle primaryBoldDark = TextStyle(
    fontSize: Dimens.fontNormal,
    fontWeight: FontWeight.bold,
    color: Palette.colorPrimaryDark,
  );
  static TextStyle primary = TextStyle(
    fontSize: Dimens.fontNormal,
    color: Palette.colorPrimary,
  );

  static TextStyle white = TextStyle(
    fontSize: Dimens.fontNormal,
    color: Colors.white,
  );
  static TextStyle whiteBold = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: Dimens.fontNormal,
    color: Colors.white,
  );
  static TextStyle text = TextStyle(
    fontSize: Dimens.fontNormal,
    color: Palette.colorText,
  );
  static TextStyle textHint = TextStyle(
    fontSize: Dimens.fontNormal,
    color: Palette.colorHint,
  );
  static TextStyle textBlue = TextStyle(
    fontSize: Dimens.fontNormal,
    color: Palette.blue,
  );
  static TextStyle textLink = TextStyle(
    fontSize: Dimens.fontNormal,
    color: Palette.colorLink,
  );

/*  static TextStyle hint = TextStyle(
    fontSize: Dimens.fontNormal,
    color: Palette.colorHint,
  );*/

  static TextStyle textBold = TextStyle(
    color: Palette.colorText,
    fontSize: Dimens.fontNormal,
    fontWeight: FontWeight.bold,
  );
/*static TextStyle textAlt = TextStyle(
    fontSize: Dimens.fontNormal,
    color: Palette.colorTextAlt,
  );*/
}

class ButtonStyles {
  static ButtonStyle primary = ButtonStyle(
      padding: MaterialStateProperty.all(EdgeInsets.zero),
      shape: MaterialStateProperty.all(
        new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(Dimens.roundedButton)),
      ));
}

class BoxDecorations {
  static const BoxDecoration white = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(
      Radius.circular(Dimens.radius),
    ),
  );

  static BoxDecoration primary = BoxDecoration(
      gradient: Gradients.primary,
      borderRadius: BorderRadius.all(Radius.circular(Dimens.radius)),
      boxShadow: [BoxShadows.primary]);

  static BoxDecoration tooltips = BoxDecoration(
      color: Palette.toolTip,
      borderRadius: BorderRadius.all(Radius.circular(4)));

  static BoxDecoration button = BoxDecoration(
      color: Palette.colorPrimary,
      borderRadius: BorderRadius.all(Radius.circular(Dimens.radius)),
      boxShadow: [BoxShadows.primary]);
}

class Gradients {
  static LinearGradient primary = LinearGradient(
    // Where the linear gradient begins and ends
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Palette.colorPrimary,
      Palette.colorPrimaryDark,
    ],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [
      Colors.transparent,
      Colors.black12,
      Colors.black26,
      Colors.black38,
      Colors.black45,
      Colors.black54,
      Colors.black87,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class BoxShadows {
  static const BoxShadow primary = BoxShadow(
    color: Colors.black12,
    offset: const Offset(1.0, 2.0),
    blurRadius: 1.0,
    spreadRadius: 1.0,
  );
}
