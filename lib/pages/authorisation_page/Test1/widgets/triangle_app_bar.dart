import 'package:flutter/material.dart';
import '../../../../design/colors.dart';
import '../../../../design/images.dart';

class TriangleAppBar extends StatelessWidget {
  const TriangleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 195,
      width: double.infinity,
      child: CustomPaint(
        painter: TriangleAppBarPainter(),
        child: Center(child: logo),
      ),
    );
  }
}

class TriangleAppBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintBlack = Paint()..color = black;
    final pathBlack = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width / 2, size.height + 45)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(pathBlack, paintBlack);

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    final shadowPath = Path()
      ..moveTo(0, size.height + 40)
      ..lineTo(size.width / 2, size.height + 85)
      ..lineTo(size.width, size.height + 40);
    canvas.drawPath(shadowPath, shadowPaint);

    final paintYellow = Paint()..color = yellow;
    final pathYellow = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width / 2, size.height + 45)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height + 40)
      ..lineTo(size.width / 2, size.height + 85)
      ..lineTo(0, size.height + 40);
    canvas.drawPath(pathYellow, paintYellow);

    final paintWhite = Paint()..color = white;
    final pathWhite = Path()
      ..moveTo(30, 0)
      ..lineTo(size.width - 30, 0)
      ..lineTo(size.width - 30, size.height - 40)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(30, size.height - 40)
      ..close();
    canvas.drawPath(pathWhite, paintWhite);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
