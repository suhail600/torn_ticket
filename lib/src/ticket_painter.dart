import 'package:flutter/material.dart';
import 'ticket_clipper.dart';

class TicketShadowPainter extends CustomPainter {
  final TicketClipper clipper;
  final double elevation;
  final Color shadowColor;
  final double shadowBlur;
  final Offset shadowOffset;

  TicketShadowPainter({
    required this.clipper,
    required this.elevation,
    required this.shadowColor,
    required this.shadowBlur,
    required this.shadowOffset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (elevation <= 0) return;

    final path = clipper.getClip(size);

    final paint = Paint()
      ..color = shadowColor.withOpacity(0.15)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowBlur);
    // ..maskFilter = MaskFilter.blur(BlurStyle.normal, elevation * 0.1);

    canvas.save();
    canvas.translate(shadowOffset.dx, elevation * shadowOffset.dy);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant TicketShadowPainter oldDelegate) {
    return elevation != oldDelegate.elevation ||
        shadowColor != oldDelegate.shadowColor ||
        shadowBlur != oldDelegate.shadowBlur ||
        shadowOffset != oldDelegate.shadowOffset;
  }
}
