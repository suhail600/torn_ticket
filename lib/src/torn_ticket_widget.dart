import 'package:flutter/material.dart';

import 'ticket_clipper.dart';
import 'ticket_painter.dart';

/// A fully customizable torn ticket widget for Flutter applications.
class TornTicket extends StatelessWidget {
  /// Creates a [TornTicket].

  /// The width of the ticket.
  final double width;

  /// The height of the ticket.
  final double height;

  /// The radius of the corners of the ticket.
  final double borderRadius;

  /// The radius of the cutout arc.
  final double cutoutRadius;

  /// The height of the cutout.
  final double cutoutHeight;

  /// The position of the cutout as a fraction of the height (0 to 1).
  final double cutoutPosition;

  /// The spacing from the bottom end of the ticket.
  final double bottomEndSpacing;

  /// The spacing between arcs at the bottom of the ticket.
  final double bottomArcSpacing;

  /// Whether the ticket has a shadow.
  final bool hasShadow;

  /// The elevation of the shadow.
  final double elevation;

  /// The color of the shadow.
  final Color shadowColor;

  /// The background color of the ticket.
  final Color backgroundColor;

  /// The background of the ticket.
  final Widget? background;

  /// Margin around the child widget.
  final EdgeInsets margin;

  /// Padding around the child widget.
  final EdgeInsetsGeometry padding;

  /// The blur intensity of the shadow.
  final double shadowBlur;

  /// The offset of the shadow.
  final Offset shadowOffset;

  /// The child widget displayed inside the ticket.
  final Widget? child;

  const TornTicket({
    super.key,
    this.child,
    this.borderRadius = 10.0,
    this.cutoutRadius = 10.0,
    this.cutoutHeight = 10.0,
    this.cutoutPosition = 0.2,
    this.bottomEndSpacing = 1.0,
    this.bottomArcSpacing = 7.0,
    this.elevation = 5.0,
    this.hasShadow = true,
    this.shadowColor = const Color(0x9A000000),
    this.backgroundColor = Colors.white,
    this.margin = const EdgeInsets.all(5),
    this.padding = const EdgeInsets.all(15),
    this.width = 300,
    this.height = 400,
    this.shadowBlur = 3,
    this.shadowOffset = const Offset(0, 0.8),
    this.background,
  })  : assert(width > 0, 'Width must be greater than 0'),
        assert(height > 0, 'Height must be greater than 0'),
        assert(cutoutPosition >= 0.05 && cutoutPosition <= 0.95,
            'cutoutPosition must be between 0.05 and 0.95');

  @override
  Widget build(BuildContext context) {
    final clipper = TicketClipper(
      radius: borderRadius,
      cutoutRadius: cutoutRadius,
      cutoutHeight: cutoutHeight,
      cutoutPosition: cutoutPosition,
      endSpacing: bottomEndSpacing,
      lineSpacing: bottomArcSpacing,
    );
    return Padding(
      padding: margin,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (hasShadow)
              Positioned.fill(
                child: CustomPaint(
                  painter: TicketShadowPainter(
                    clipper: clipper,
                    elevation: elevation,
                    shadowColor: shadowColor,
                    shadowBlur: shadowBlur,
                    shadowOffset: shadowOffset,
                  ),
                ),
              ),
            ClipPath(
              clipper: clipper,
              child: ColoredBox(
                color: backgroundColor,
                child: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: [
                    if (background != null) background!,
                    if (child != null) Padding(padding: padding, child: child),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
