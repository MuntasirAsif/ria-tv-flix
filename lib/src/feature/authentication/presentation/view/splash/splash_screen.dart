import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/gen/assets.gen.dart';
import '../../../../../../core/routes/route_const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    Timer(const Duration(seconds: 3), () {
      if (mounted) context.go(RouteConst.login);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return SizedBox(
              width: 300.w,
              height: 300.w,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _buildOrbitRing(280.w, Colors.blue.withValues(alpha: 0.2), 0),
                  _buildOrbitRing(
                    200.w,
                    Colors.purple.withValues(alpha: 0.2),
                    0.3,
                  ),
                  _buildOrbitRing(
                    120.w,
                    Colors.teal.withValues(alpha: 0.2),
                    0.6,
                  ),
                  Assets.images.appLogoCom.image(width: 160.w),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOrbitRing(double size, Color color, double offset) {
    final rotation = (_controller.value + offset) % 1.0;
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateZ(rotation * 3.14159 * 2),
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          children: [
            Center(
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 1.5),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
