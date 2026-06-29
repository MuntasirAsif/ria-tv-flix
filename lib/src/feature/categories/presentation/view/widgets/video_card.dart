import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/routes/route_const.dart';
import '../../../../../../core/static/theme/theme.dart';
import '../../../../../widgets/custom_network_image.dart' show CustomNetworkImage;
import '../../../../home/data/model/content_model.dart' show ContentModel;

class VideoCard extends StatelessWidget {
  final ContentModel item;

  const VideoCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(RouteConst.videoPlayer, extra: item),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: context.color.primary.withValues(alpha: 0.15),
                    blurRadius: 12.r,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CustomNetworkImage(
                      imageUrl: item.thumbnailUrl,
                      radius: 0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.5),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 6.r,
                      bottom: 6.r,
                      child: Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: context.color.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: context.color.primary.withValues(alpha: 0.4),
                              blurRadius: 8.r,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: FaIcon(FontAwesomeIcons.play, size: 10, color: Colors.white),
                      ),
                    ),
                    Positioned(
                      left: 6.r,
                      top: 6.r,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.r, vertical: 3.r),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          item.duration,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
          2.verticalSpace,
          Text(
            item.publishDate,
            style:             context.textStyle.bodySmall.copyWith(
              fontSize: 10.sp,
              color: context.color.text.secondary.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
