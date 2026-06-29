import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/static/theme/theme.dart';
import '../../view_model/tv_provider.dart' show TvChannel;
import 'channel_card.dart';

class ChannelCategory extends StatelessWidget {
  final String title;
  final FaIconData icon;
  final List<TvChannel> channels;

  const ChannelCategory({
    super.key,
    required this.title,
    required this.icon,
    required this.channels,
  });

  @override
  Widget build(BuildContext context) {
    if (channels.isEmpty) return const SizedBox();

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
                    gradient: LinearGradient(
                      colors: [context.color.primary, const Color(0xFFFFD700)],
                    ),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                10.horizontalSpace,
                FaIcon(icon, size: 14, color: context.color.primary),
                8.horizontalSpace,
                Expanded(
                  child: Text(
                    title,
                    style: context.textStyle.headingSmall.copyWith(
                      letterSpacing: 0.5,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                FaIcon(
                  FontAwesomeIcons.chevronRight,
                  size: 12,
                  color: context.color.text.secondary.withValues(alpha: 0.4),
                ),
              ],
            ),
          ),
          14.verticalSpace,
          SizedBox(
            height: 168.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: channels.length,
              padding: EdgeInsets.only(right: context.padding.p16.r),
              separatorBuilder: (_, _) => 12.horizontalSpace,
              itemBuilder: (context, index) =>
                  ChannelCard(channel: channels[index]),
            ),
          ),
        ],
      ),
    );
  }
}
