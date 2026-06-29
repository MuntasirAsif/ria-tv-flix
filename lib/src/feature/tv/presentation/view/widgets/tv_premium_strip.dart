import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/static/theme/theme.dart';
import 'premium_mini_card.dart';

class TvPremiumStrip extends StatelessWidget {
  final List premium;
  const TvPremiumStrip({super.key, required this.premium});

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.fromLTRB(context.padding.p16.r, 12.h, 0, 4.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: context.padding.p16.r),
          child: Row(
            children: [
              Container(
                width: 3.r,
                height: 16.r,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                  ),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              8.horizontalSpace,
              FaIcon(
                FontAwesomeIcons.star,
                size: 13,
                color: const Color(0xFFFFD700),
              ),
              6.horizontalSpace,
              Text(
                'Premium Channels',
                style: context.textStyle.labelLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
              const Spacer(),
              Text(
                '${premium.length} channels',
                style: context.textStyle.labelSmall.copyWith(
                  fontSize: 10.sp,
                  color: context.color.text.secondary.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
        10.verticalSpace,
        SizedBox(
          height: 112.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: premium.length,
            separatorBuilder: (_, _) => 8.horizontalSpace,
            itemBuilder: (context, index) =>
                PremiumMiniCard(channel: premium[index]),
          ),
        ),
      ],
    ),
  );
}
