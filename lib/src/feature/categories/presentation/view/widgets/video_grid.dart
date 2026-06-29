import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/static/theme/theme.dart';
import '../../../../home/data/model/content_model.dart';
import 'video_card.dart';

class VideoGrid extends StatelessWidget {
  final List<ContentModel> items;

  const VideoGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(FontAwesomeIcons.videoSlash, size: 40, color: context.color.primary.withValues(alpha: 0.3)),
            12.verticalSpace,
            Text('No videos available', style: context.textStyle.bodyLarge),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.padding.p16.r),
      child: GridView.builder(
        padding: EdgeInsets.only(top: 4.r, bottom: 16.r),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.62,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) => VideoCard(item: items[index]),
      ),
    );
  }
}
