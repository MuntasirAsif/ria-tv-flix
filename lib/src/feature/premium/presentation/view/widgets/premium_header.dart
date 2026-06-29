import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/static/theme/theme.dart';

class PremiumHeader extends StatelessWidget {
  const PremiumHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        context.padding.p16.r,
        24.h,
        context.padding.p16.r,
        24.h,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.color.primary,
            context.color.primary.withValues(alpha: 0.6),
            const Color(0xFFFFD700).withValues(alpha: 0.3),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: const Color(0xFFFFD700),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFD700).withValues(alpha: 0.4),
                  blurRadius: 16.r,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: FaIcon(
              FontAwesomeIcons.crown,
              size: 24,
              color: Colors.black87,
            ),
          ),
          12.verticalSpace,
          Text(
            'Go Premium',
            style: context.textStyle.headingLarge.copyWith(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          6.verticalSpace,
          Text(
            'Unlock the best entertainment experience',
            style: context.textStyle.bodyMedium.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
