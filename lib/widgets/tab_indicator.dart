import 'package:flutter/material.dart';

class TabIndicator extends Decoration {
  final Color color;
  final double radius;
  final double height;

  TabIndicator(
      {this.color = Colors.white, this.height = 3, @required this.radius});

  @override
  BoxPainter createBoxPainter([onChanged]) => _RoundedPainter(this);
}

class _RoundedPainter extends BoxPainter {
  final Paint _paint;
  final TabIndicator decoration;

  _RoundedPainter(this.decoration)
      : _paint = Paint()
          ..color = decoration.color
          ..style = PaintingStyle.fill
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    var _indicatorWidth = 48.0;
    final Offset circleOffset = offset +
        Offset(cfg.size.width / 2 - (_indicatorWidth / 2),
            cfg.size.height - decoration.radius - 10);
    var rect = circleOffset & Size(_indicatorWidth, decoration.height ?? 3);
    canvas.drawRRect(
        RRect.fromRectAndCorners(rect,
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8)),
        _paint);
  }
}
