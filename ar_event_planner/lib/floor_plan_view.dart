import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as fl;
import 'package:vector_math/vector_math_64.dart';
import 'dart:math' as math;

class FloorPlanView extends StatelessWidget {
  final List<Vector3> points;

  FloorPlanView(this.points);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Floor Plan'),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: CustomPaint(
            size: Size.infinite,
            painter: FloorPlanPainter(points),
          ),
        ),
      ),
    );
  }
}

class FloorPlanPainter extends CustomPainter {
  final List<Vector3> points;
  late List<Offset> scaledPoints;

  FloorPlanPainter(this.points) {
    scaledPoints = _scalePoints();
  }

  List<Offset> _scalePoints() {
    if (points.isEmpty) return [];

    // Find the bounding box
    double minX = points.map((p) => p.x).reduce(math.min);
    double maxX = points.map((p) => p.x).reduce(math.max);
    double minZ = points.map((p) => p.z).reduce(math.min);
    double maxZ = points.map((p) => p.z).reduce(math.max);

    // Calculate the scale factor
    double scaleX = 1 / (maxX - minX);
    double scaleZ = 1 / (maxZ - minZ);
    double scale = math.min(scaleX, scaleZ) * 0.8; // 0.8 to leave some margin

    // Scale and translate points
    return points
        .map((p) => Offset(
              (p.x - minX) * scale + 0.1, // 0.1 to add some margin
              (p.z - minZ) * scale + 0.1, // 0.1 to add some margin
            ))
        .toList();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = fl.Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final roomPaint = Paint()
      ..color = fl.Colors.blue.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    if (scaledPoints.isNotEmpty) {
      Path path = Path();
      path.moveTo(
          scaledPoints[0].dx * size.width, scaledPoints[0].dy * size.height);

      for (int i = 1; i < scaledPoints.length; i++) {
        path.lineTo(
            scaledPoints[i].dx * size.width, scaledPoints[i].dy * size.height);
      }

      path.close();

      canvas.drawPath(path, roomPaint);
      canvas.drawPath(path, paint);

      // Draw points
      final pointPaint = Paint()
        ..color = fl.Colors.red
        ..strokeWidth = 5.0
        ..style = PaintingStyle.fill;

      for (var point in scaledPoints) {
        canvas.drawCircle(Offset(point.dx * size.width, point.dy * size.height),
            3, pointPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
