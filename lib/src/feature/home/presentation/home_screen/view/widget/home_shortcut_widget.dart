import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/static/theme/theme.dart';

class HomeShortCutWidget extends StatelessWidget {
  const HomeShortCutWidget({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.padding.p12.r),
      decoration: BoxDecoration(
        color: context.color.onPrimary,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: context.color.primary.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 25.h,
              width: 25.w,
              alignment: Alignment.center,
              padding: EdgeInsets.all(5.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withValues(alpha: 0.2),
              ),
              child: Center(
                child: Icon(icon, color: color, size: 12.r),
              ),
            ),
          ),
          10.verticalSpace,
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: context.textStyle.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              description,
              style: context.textStyle.bodySmall.copyWith(
                color: context.color.text.secondary,
              ),
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 500.ms).slideX(duration: 500.ms);
  }
}
