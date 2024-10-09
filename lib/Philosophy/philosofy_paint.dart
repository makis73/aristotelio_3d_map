// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PhilosophyPaint extends CustomPainter {
  PhilosophyPaint({
    required this.context,
    required this.mapController,
    required this.offsets,
    required this.position,
  });
  final BuildContext context;
  final GoogleMapController mapController;
  final Map<String, Map<String, double>> offsets;
  final CameraPosition position;

  // //* Function to get the Screen coordinates of building

  @override
  void paint(Canvas canvas, Size size) {
    final bearing = position.bearing;

    double dxOffset = -5;
    double dyOffset =
        position.zoom <= 18 ? position.zoom * 0.5 : position.zoom * 1.2;

    double leftX = offsets['left']!['x']!;
    double leftY = offsets['left']!['y']!;
    double topX = offsets['top']!['x']!;
    double topY = offsets['top']!['y']!;
    double rightX = offsets['right']!['x']!;
    double rightY = offsets['right']!['y']!;
    double bottomX = offsets['bottom']!['x']!;
    double bottomY = offsets['bottom']!['y']!;

    final lightColor = Color(0xFF00b4d8);
    final mediumColor = Color(0xFF0096c7);
    final darkColor = Color(0xFF0077b6);

    final linePaint = Paint()
      ..color = const Color.fromARGB(115, 91, 91, 91)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final backLinePaint = Paint()
      ..color = const Color.fromARGB(255, 124, 123, 123)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // final backPaint = Paint()
    //   ..color = Colors.blue.withOpacity(0.3)
    //   ..style = PaintingStyle.fill;

    final frontPaint = Paint()
      ..color = lightColor
      ..style = PaintingStyle.fill;

    final bottomWallPaint = Paint()
      ..color = darkColor
      ..style = PaintingStyle.fill;

    final rightWallPaint = Paint()
      ..color = mediumColor
      ..style = PaintingStyle.fill;

    final leftWallPaint = Paint()
      ..color = bearing > 226 ? lightColor : mediumColor
      ..style = PaintingStyle.fill;

    final frontWallPaint = Paint()
      ..color = darkColor
      ..style = PaintingStyle.fill;

    Offset backBottomLeft = Offset.zero;
    Offset backTopLeft = Offset((topX - leftX), (topY - leftY));
    Offset backTopRight = Offset((rightX - leftX), (rightY - leftY));
    Offset backBottomRight = Offset((bottomX - leftX), (bottomY - leftY));

    Offset frontBottomLeft = Offset(dxOffset, -dyOffset);
    Offset frontTopLeft =
        Offset(backTopLeft.dx + dxOffset, backTopLeft.dy - dyOffset);
    Offset frontTopRight =
        Offset(backTopRight.dx + dxOffset, backTopRight.dy - dyOffset);
    Offset frontBottomRight =
        Offset(backBottomRight.dx + dxOffset, backBottomRight.dy - dyOffset);

    var backPath = Path()
      ..moveTo(backBottomLeft.dx, backBottomLeft.dy)
      ..lineTo(backTopLeft.dx, backTopLeft.dy)
      ..lineTo(backTopRight.dx, backTopRight.dy)
      ..lineTo(backBottomRight.dx, backBottomRight.dy)
      ..lineTo(backBottomLeft.dx, backBottomLeft.dy);

    var frontPath = Path()
      ..moveTo(frontBottomLeft.dx, frontBottomLeft.dy)
      ..lineTo(frontTopLeft.dx, frontTopLeft.dy)
      ..lineTo(frontTopRight.dx, frontTopRight.dy)
      ..lineTo(frontBottomRight.dx, frontBottomRight.dy)
      ..lineTo(frontBottomLeft.dx, frontBottomLeft.dy);

    var bottomWallPath = Path()
      ..moveTo(backBottomLeft.dx, backBottomLeft.dy)
      ..lineTo(frontBottomLeft.dx, frontBottomLeft.dy)
      ..lineTo(frontBottomRight.dx, frontBottomRight.dy)
      ..lineTo(backBottomRight.dx, backBottomRight.dy);

    var rightWallPath = Path()
      ..moveTo(backBottomRight.dx, backBottomRight.dy)
      ..lineTo(frontBottomRight.dx, frontBottomRight.dy)
      ..lineTo(frontTopRight.dx, frontTopRight.dy)
      ..lineTo(backTopRight.dx, backTopRight.dy);

    var leftWallPath = Path()
      ..moveTo(backBottomLeft.dx, backBottomLeft.dy)
      ..lineTo(frontBottomLeft.dx, frontBottomLeft.dy)
      ..lineTo(frontTopLeft.dx, frontTopLeft.dy)
      ..lineTo(backTopLeft.dx, backTopLeft.dy);

    var frontWallPath = Path()
      ..moveTo(backTopLeft.dx, backTopLeft.dy)
      ..lineTo(frontTopLeft.dx, frontTopLeft.dy)
      ..lineTo(frontTopRight.dx, frontTopRight.dy)
      ..lineTo(backTopRight.dx, backTopRight.dy);

    //* Draw Frond, Back and Walls layers
    // canvas.drawPath(backPath, backPaint);
    if (bearing > 300) {
      canvas.drawPath(leftWallPath, leftWallPaint);
      canvas.drawPath(bottomWallPath, bottomWallPaint);
      canvas.drawPath(frontWallPath, frontWallPaint);
      canvas.drawPath(frontPath, frontPaint);
      canvas.drawPath(rightWallPath, rightWallPaint);
    }

    if (bearing > 270 && bearing < 300) {
      canvas.drawPath(frontWallPath, frontWallPaint);
      canvas.drawPath(rightWallPath, rightWallPaint);
      canvas.drawPath(leftWallPath, leftWallPaint);
      canvas.drawPath(bottomWallPath, bottomWallPaint);
      canvas.drawPath(frontPath, frontPaint);
    }

    if (bearing < 270 && bearing > 226) {
      canvas.drawPath(bottomWallPath, bottomWallPaint);
      canvas.drawPath(rightWallPath, rightWallPaint);
      canvas.drawPath(leftWallPath, leftWallPaint);
      canvas.drawPath(frontWallPath, frontWallPaint);
      canvas.drawPath(frontPath, frontPaint);
    }

    if (bearing < 226 && bearing > 130) {
      canvas.drawPath(bottomWallPath, bottomWallPaint);
      canvas.drawPath(frontWallPath, frontWallPaint);
      canvas.drawPath(rightWallPath, rightWallPaint);
      canvas.drawPath(leftWallPath, leftWallPaint);
      canvas.drawPath(frontPath, frontPaint);
    }

    if (bearing < 130) {
      canvas.drawPath(frontWallPath, frontWallPaint);
      canvas.drawPath(rightWallPath, rightWallPaint);
      canvas.drawPath(leftWallPath, leftWallPaint);
      canvas.drawPath(bottomWallPath, bottomWallPaint);
      canvas.drawPath(frontPath, frontPaint);
    }
    //* Draw Lines to connect Back - Front layers and all edges
    // canvas.drawLine(frontTopLeft, backTopLeft, backLinePaint);
    // canvas.drawLine(frontTopRight, backTopRight, linePaint);
    // canvas.drawLine(frontBottomLeft, backBottomLeft, linePaint);
    // canvas.drawLine(frontBottomRight, backBottomRight, linePaint);

    // canvas.drawLine(frontTopRight, frontTopLeft, linePaint);
    // canvas.drawLine(frontBottomRight, frontBottomLeft, linePaint);
    // canvas.drawLine(frontBottomRight, frontTopRight, linePaint);
    // canvas.drawLine(frontBottomLeft, frontTopLeft, linePaint);

    // canvas.drawLine(backTopRight, backTopLeft, backLinePaint);
    // canvas.drawLine(backBottomRight, backBottomLeft, linePaint);
    // canvas.drawLine(backBottomRight, backTopRight, linePaint);
    // canvas.drawLine(backBottomLeft, backTopLeft, backLinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
