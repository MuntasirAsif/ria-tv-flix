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
        width: 75.w,
        child: Column(
          children: [
            Container(
              width: 75.w,
              height: 75.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
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
                borderRadius: BorderRadius.circular(100.r),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: channel.logoUrl,
                      width: 71.w,
                      height: 71.w,
                      fit: BoxFit.cover,
                      placeholder: (_, _) => Container(
                        width: 71.w,
                        height: 71.w,
                        color: context.color.primary.withValues(alpha: 0.04),
                      ),
                      errorWidget: (_, _, _) => Container(
                        width: 71.w,
                        height: 71.w,
                        color: context.color.primary.withValues(alpha: 0.04),
                        child: Icon(
                          Icons.live_tv_rounded,
                          size: 20,
                          color: context.color.icon.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                    if (channel.isPremium) ...[
                      Positioned(
                        top: 2.r,
                        right: 2.r,
                        child: Container(
                          padding: EdgeInsets.all(3.r),
                          decoration: BoxDecoration(
                            color: gold,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: gold.withValues(alpha: 0.5),
                                blurRadius: 4.r,
                              ),
                            ],
                          ),
                          child: FaIcon(
                            FontAwesomeIcons.crown,
                            size: 7,
                            color: context.color.text.primary,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 2.r,
                        left: 2.r,
                        right: 2.r,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 1.r),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                gold.withValues(alpha: 0.9),
                                orange.withValues(alpha: 0.9),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'PREMIUM',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 5.sp,
                              fontWeight: FontWeight.w700,
                              color: context.color.text.primary,
                              letterSpacing: 0.5,
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
              style: context.textStyle.labelSmall.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
                fontSize: 10.sp,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            Text(
              'CH ${channel.channelNumber}',
              style: context.textStyle.labelSmall.copyWith(
                fontSize: 7.sp,
                color: context.color.text.secondary.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
