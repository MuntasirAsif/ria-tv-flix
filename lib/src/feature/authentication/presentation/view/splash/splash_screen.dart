import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:ria_tv_flix/core/static/theme/theme.dart';

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
  final _random = Random();
  late List<String> _ringImages;

  static const _splashPaths = [
    'assets/images/splash/image 1.jpg',
    'assets/images/splash/image 2.png',
    'assets/images/splash/image 4.webp',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _pickImages();
    Timer.periodic(const Duration(seconds: 3), (_) => _pickImages());

    Timer(const Duration(seconds: 3), () {
      if (mounted) context.go(RouteConst.login);
    });
  }

  void _pickImages() {
    final shuffled = List<String>.from(_splashPaths)..shuffle(_random);
    _ringImages = shuffled.take(3).toList();
    if (mounted) setState(() {});
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return SizedBox(
                  width: 300.w,
                  height: 300.w,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      _buildOrbitRing(
                        280.w,
                        Colors.blue.withValues(alpha: 0.2),
                        0,
                        _ringImages[0],
                      ),
                      _buildOrbitRing(
                        200.w,
                        Colors.purple.withValues(alpha: 0.2),
                        0.3,
                        _ringImages[1],
                      ),
                      _buildOrbitRing(
                        120.w,
                        Colors.teal.withValues(alpha: 0.2),
                        0.6,
                        _ringImages[2],
                      ),
                      Assets.images.appLogoCom.image(width: 160.w),
                    ],
                  ),
                );
              },
            ),
            30.verticalSpace,
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Text(
                '৩ টাকায় বিনোদন',
                style: GoogleFonts.balooDa2(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: context.color.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrbitRing(
    double size,
    Color color,
    double offset,
    String imagePath,
  ) {
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
                child: ClipOval(
                  child: Image.asset(
                    imagePath,
                    width: 22,
                    height: 22,
                    fit: BoxFit.cover,
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
