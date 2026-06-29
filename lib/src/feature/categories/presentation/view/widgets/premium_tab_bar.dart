import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/static/theme/theme.dart';

class PremiumTabBar extends StatelessWidget {
  final TabController tabController;
  final int currentIndex;

  const PremiumTabBar({
    super.key,
    required this.tabController,
    required this.currentIndex,
  });

  static const labels = [
    'All', 'Originals', 'Music', 'Action', 'Bangla',
    'Romantic', 'Natok', 'Sports', 'Cartoon',
  ];

  static const icons = [
    FontAwesomeIcons.layerGroup,
    FontAwesomeIcons.star,
    FontAwesomeIcons.music,
    FontAwesomeIcons.fire,
    FontAwesomeIcons.film,
    FontAwesomeIcons.heart,
    FontAwesomeIcons.clapperboard,
    FontAwesomeIcons.baseball,
    FontAwesomeIcons.child,
  ];

  static const filters = [
    null, 'original', 'music', 'action', 'bangla',
    'romantic', 'natok', 'sports', 'cartoon',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top + 8.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.padding.p16.r),
          child: Row(
            children: [
              FaIcon(FontAwesomeIcons.tableCellsLarge, size: 20, color: context.color.primary),
              10.horizontalSpace,
              Text('Categories', style: context.textStyle.headingMedium.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              )),
            ],
          ),
        ),
        16.verticalSpace,
        SizedBox(
          height: 38.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: context.padding.p16.r),
            itemCount: labels.length,
            itemBuilder: (context, index) {
              final isSelected = currentIndex == index;
              return GestureDetector(
                onTap: () => tabController.animateTo(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: EdgeInsets.only(right: 8.r),
                  padding: EdgeInsets.symmetric(horizontal: 14.r, vertical: 8.r),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [context.color.primary, context.color.primary.withValues(alpha: 0.7)],
                          )
                        : null,
                    color: isSelected ? null : context.color.primary.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(19.r),
                    border: isSelected
                        ? null
                        : Border.all(color: context.color.primary.withValues(alpha: 0.08)),
                    boxShadow: isSelected
                        ? [BoxShadow(
                            color: context.color.primary.withValues(alpha: 0.3),
                            blurRadius: 8.r,
                            offset: const Offset(0, 2),
                          )]
                        : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(
                        icons[index],
                        size: 12,
                        color: isSelected ? Colors.white : context.color.primary.withValues(alpha: 0.7),
                      ),
                      6.horizontalSpace,
                      Text(
                        labels[index],
                        style: context.textStyle.labelMedium.copyWith(
                          color: isSelected ? Colors.white : context.color.text.primary.withValues(alpha: 0.6),
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        16.verticalSpace,
      ],
    );
  }
}
