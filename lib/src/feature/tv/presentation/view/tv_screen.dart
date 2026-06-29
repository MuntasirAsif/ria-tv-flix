import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../view_model/tv_provider.dart' show tvChannelProvider;
import 'widgets/channel_category.dart';
import 'widgets/tv_header.dart';
import 'widgets/tv_premium_strip.dart';

class TvScreen extends ConsumerWidget {
  const TvScreen({super.key});

  static const _categories = [
    ('News', FontAwesomeIcons.newspaper, 'news'),
    ('Sports', FontAwesomeIcons.baseball, 'sports'),
    ('Entertainment', FontAwesomeIcons.tv, 'entertainment'),
    ('Music', FontAwesomeIcons.music, 'music'),
    ('Kids', FontAwesomeIcons.child, 'kids'),
    ('Documentary', FontAwesomeIcons.globe, 'documentary'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channels = ref.watch(tvChannelProvider);
    final premium = channels.where((c) => c.isPremium).toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            TvHeader(channelCount: channels.length),
            if (premium.isNotEmpty) TvPremiumStrip(premium: premium),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 8.h),
                children: _categories.map((c) {
                  final filtered = channels
                      .where((ch) => ch.category == c.$3)
                      .toList();
                  return ChannelCategory(
                    title: c.$1,
                    icon: c.$2,
                    channels: filtered,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
