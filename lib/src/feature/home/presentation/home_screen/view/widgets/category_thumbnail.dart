import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/routes/route_const.dart';
import '../../../../../../../core/static/theme/theme.dart';
import '../../../../../../widgets/custom_network_image.dart';
import '../../../../data/model/content_model.dart';

class CategoryThumbnail extends StatelessWidget {
  final ContentModel item;

  const CategoryThumbnail({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(RouteConst.videoPlayer, extra: item),
      child: SizedBox(
        width: 110.w,
        child: ClipRect(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                boxShadow: [
                  BoxShadow(
                    color: context.color.primary.withValues(alpha: 0.12),
                    blurRadius: 14.r,
                    offset: const Offset(0, 6),
                  ),
                  BoxShadow(
                    color: context.color.primary.withValues(alpha: 0.05),
                    blurRadius: 4.r,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: Stack(
                  children: [
                    CustomNetworkImage(
                      imageUrl: item.thumbnailUrl,
                      height: 155,
                      width: 110,
                      radius: 0,
                    ),
                    Container(
                      height: 155,
                      width: 110,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.55),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 6.r,
                      bottom: 6.r,
                      child: Container(
                        padding: EdgeInsets.all(7.r),
                        decoration: BoxDecoration(
                          color: context.color.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: context.color.primary.withValues(
                                alpha: 0.4,
                              ),
                              blurRadius: 8.r,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.play,
                          size: 11,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            8.verticalSpace,
            Text(
              item.title,
              style: context.textStyle.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        ),
      ),
    );
  }
}
