import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/static/theme/theme.dart';

class PlanButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool outlined;
  final bool gold;

  const PlanButton({
    super.key,
    required this.label,
    required this.onTap,
    this.outlined = false,
    this.gold = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: gold
              ? const Color(0xFFFFD700)
              : outlined
              ? Colors.transparent
              : context.color.primary,
          borderRadius: BorderRadius.circular(14.r),
          border: outlined
              ? Border.all(color: context.color.primary.withValues(alpha: 0.3))
              : null,
          boxShadow: [
            BoxShadow(
              color: gold
                  ? const Color(0xFFFFD700).withValues(alpha: 0.4)
                  : outlined
                  ? Colors.transparent
                  : context.color.primary.withValues(alpha: 0.3),
              blurRadius: 12.r,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: gold
                  ? Colors.black87
                  : outlined
                  ? context.color.text.secondary
                  : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
