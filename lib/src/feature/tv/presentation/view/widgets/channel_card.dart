import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/static/theme/theme.dart';
import '../../view_model/tv_provider.dart' show TvChannel;

class ChannelCard extends StatelessWidget {
  final TvChannel channel;

  const ChannelCard({super.key, required this.channel});

  @override
  Widget build(BuildContext context) {
    final gold = const Color(0xFFFFD700);
    final orange = const Color(0xFFFFA500);

    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 110.w,
        child: Column(
          children: [
            Container(
              width: 110.w,
              height: 110.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                gradient: channel.isPremium
                    ? LinearGradient(
                        colors: [gold, orange, context.color.primary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: channel.isPremium
                    ? null
                    : context.color.primary.withValues(alpha: 0.06),
                boxShadow: [
                  BoxShadow(
                    color: (channel.isPremium ? gold : context.color.primary)
                        .withValues(alpha: 0.15),
                    blurRadius: 10.r,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: EdgeInsets.all(2.r),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: channel.logoUrl,
                      width: 110.w,
                      height: 106.w,
                      fit: BoxFit.cover,
                      placeholder: (_, _) => Container(
                        width: 110.w,
                        height: 106.w,
                        color: context.color.primary.withValues(alpha: 0.04),
                      ),
                      errorWidget: (_, _, _) => Container(
                        width: 110.w,
                        height: 106.w,
                        color: context.color.primary.withValues(alpha: 0.04),
                        child: Icon(
                          Icons.live_tv_rounded,
                          size: 28,
                          color: context.color.icon.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                    if (channel.isPremium) ...[
                      Positioned(
                        top: 4.r,
                        right: 4.r,
                        child: Container(
                          padding: EdgeInsets.all(4.r),
                          decoration: BoxDecoration(
                            color: gold,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: gold.withValues(alpha: 0.5),
                                blurRadius: 6.r,
                              ),
                            ],
                          ),
                          child: FaIcon(
                            FontAwesomeIcons.crown,
                            size: 10,
                            color: context.color.text.primary,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 4.r,
                        left: 4.r,
                        right: 4.r,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 2.r),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                gold.withValues(alpha: 0.9),
                                orange.withValues(alpha: 0.9),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            'PREMIUM',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 7.sp,
                              fontWeight: FontWeight.w700,
                              color: context.color.text.primary,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            8.verticalSpace,
            Text(
              channel.name,
              style: context.textStyle.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            2.verticalSpace,
            Text(
              'CH ${channel.channelNumber}',
              style: context.textStyle.labelSmall.copyWith(
                fontSize: 9.sp,
                color: context.color.text.secondary.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
