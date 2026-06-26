import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/routes/route_const.dart';
import '../../../../../../../core/static/theme/theme.dart';
import '../../../../data/model/content_model.dart';
import 'category_thumbnail.dart';

class CategorySection extends StatelessWidget {
  final String title;
  final List<ContentModel> items;

  const CategorySection({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: context.padding.p16.r, bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: context.padding.p16.r),
            child: Row(
              children: [
                Container(
                  width: 3.r,
                  height: 18.r,
                  decoration: BoxDecoration(
                    color: context.color.primary,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                10.horizontalSpace,
                Expanded(
                  child: Text(
                    title,
                    style: context.textStyle.headingSmall.copyWith(
                      letterSpacing: 0.5,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                12.horizontalSpace,
                GestureDetector(
                  onTap: () => context.go(RouteConst.categoriesScreen),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.r,
                      vertical: 4.r,
                    ),
                    decoration: BoxDecoration(
                      color: context.color.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: context.color.primary.withValues(alpha: 0.15),
                        width: 0.5,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'See All',
                          style: context.textStyle.bodyMedium.copyWith(
                            color: context.color.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 11.sp,
                          ),
                        ),
                        4.horizontalSpace,
                        FaIcon(
                          FontAwesomeIcons.chevronRight,
                          size: 8,
                          color: context.color.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          14.verticalSpace,
          SizedBox(
            height: 175.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              padding: EdgeInsets.only(right: context.padding.p16.r),
              separatorBuilder: (_, _) => 10.horizontalSpace,
              itemBuilder: (context, index) =>
                  CategoryThumbnail(item: items[index]),
            ),
          ),
        ],
      ),
    );
  }
}
