import 'package:flutter/material.dart';

class TicketClipper extends CustomClipper<Path> {
  final double radius;
  final double cutoutRadius;
  final double cutoutHeight;
  final double cutoutPosition;
  final double endSpacing;
  final double lineSpacing;

  TicketClipper({
    required this.radius,
    required this.cutoutRadius,
    required this.cutoutHeight,
    required this.cutoutPosition,
    required this.endSpacing,
    required this.lineSpacing,
  });

  @override
  Path getClip(Size size) {
    Path path = Path();

    final cutoutPos = size.height * cutoutPosition;

    path.moveTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    path.lineTo(size.width - radius, 0);

    path.quadraticBezierTo(size.width, 0, size.width, radius);

    path.lineTo(size.width, cutoutPos - cutoutRadius);
    path.arcToPoint(
      Offset(size.width, cutoutPos + cutoutHeight),
      radius: Radius.circular(cutoutRadius),
      clockwise: false,
    );

    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(
        size.width, size.height, size.width - radius, size.height);

    double availableWidth = size.width - (2 * radius) - (2 * endSpacing);
    int numberOfArcs = (availableWidth / (2 * lineSpacing)).floor();
    double totalLineSpacing = (numberOfArcs - 1) * lineSpacing;
    double arcWidth = (availableWidth - totalLineSpacing) / numberOfArcs;
    double arcRadius = arcWidth / 2;

    double currentX = size.width - radius - endSpacing;

    for (int i = 0; i < numberOfArcs; i++) {
      path.lineTo(currentX, size.height);

      path.arcToPoint(
        Offset(currentX - arcWidth, size.height),
        radius: Radius.circular(arcRadius),
        clockwise: false,
      );

      currentX -= (arcWidth + lineSpacing);
    }

    path.lineTo(radius, size.height);

    path.quadraticBezierTo(0, size.height, 0, size.height - radius);
    path.lineTo(0, cutoutPos + cutoutHeight);

    path.arcToPoint(
      Offset(0, cutoutPos - cutoutRadius),
      radius: Radius.circular(cutoutRadius),
      clockwise: false,
    );

    path.lineTo(0, radius);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    if (oldClipper is TicketClipper) {
      return radius != oldClipper.radius ||
          cutoutRadius != oldClipper.cutoutRadius ||
          cutoutHeight != oldClipper.cutoutHeight ||
          cutoutPosition != oldClipper.cutoutPosition ||
          endSpacing != oldClipper.endSpacing ||
          lineSpacing != oldClipper.lineSpacing;
    }
    return true;
  }
}
