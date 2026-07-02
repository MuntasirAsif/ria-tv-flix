import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/static/theme/theme.dart';
import '../../view_model/premium_provider.dart' show PremiumPlan;

class SubscriptionCard extends StatelessWidget {
  final PremiumPlan plan;
  const SubscriptionCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    final gold = const Color(0xFFFFD700);
    final pop = plan.isPopular;

    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 190.w,
        padding: EdgeInsets.fromLTRB(14.r, 16.r, 12.r, 14.r),
        decoration: BoxDecoration(
          gradient: pop
              ? LinearGradient(colors: [gold, const Color(0xFFFF8C00)])
              : null,
          color: pop ? null : context.color.primary.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: pop ? gold : context.color.primary.withValues(alpha: 0.1),
            width: pop ? 1.5 : 1,
          ),
          boxShadow: pop
              ? [
                  BoxShadow(
                    color: gold.withValues(alpha: 0.25),
                    blurRadius: 12.r,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    plan.name,
                    style: context.textStyle.headingSmall.copyWith(
                      fontWeight: FontWeight.w700,
                      color: pop ? Colors.white : null,
                    ),
                  ),
                ),
                if (pop)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.r,
                      vertical: 2.r,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'BEST',
                      style: TextStyle(
                        fontSize: 7.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                  ),
              ],
            ),
            10.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan.price,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                    color: pop ? Colors.white : context.color.text.primary,
                  ),
                ),
                Text(
                  plan.period,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: pop
                        ? Colors.white70
                        : context.color.text.secondary.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
            10.verticalSpace,
            ...plan.benefits.map(
              (b) => Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.check,
                      size: 8,
                      color: pop ? Colors.white : context.color.success,
                    ),
                    6.horizontalSpace,
                    Flexible(
                      child: Text(
                        b,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textStyle.bodySmall.copyWith(
                          fontSize: 10.sp,
                          color: pop
                              ? Colors.white70
                              : context.color.text.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (plan.isCurrent)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Center(
                  child: Text(
                    'Current Plan',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: pop ? Colors.white70 : context.color.primary,
                    ),
                  ),
                ),
              )
            else
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 8.r),
                  decoration: BoxDecoration(
                    color: pop ? Colors.white : context.color.primary,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      'Subscribe',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: pop ? Colors.black87 : Colors.white,
                      ),
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
