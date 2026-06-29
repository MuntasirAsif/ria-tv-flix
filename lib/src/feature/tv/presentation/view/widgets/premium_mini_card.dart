import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/static/theme/theme.dart';

class PremiumMiniCard extends StatelessWidget {
  final dynamic channel;

  const PremiumMiniCard({super.key, required this.channel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 90.w,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFD700), Color(0xFFFF8C00)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFFD700).withValues(alpha: 0.2),
              blurRadius: 8.r,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(2.r),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: CachedNetworkImage(
            imageUrl: channel.logoUrl,
            width: 86.w,
            height: 108.h,
            fit: BoxFit.cover,
            placeholder: (_, _) =>
                Container(color: context.color.primary.withValues(alpha: 0.04)),
            errorWidget: (_, _, _) => Container(
              color: context.color.primary.withValues(alpha: 0.04),
              child: Icon(
                Icons.live_tv_rounded,
                color: context.color.icon.withValues(alpha: 0.3),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
