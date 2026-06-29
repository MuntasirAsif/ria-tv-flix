import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/static/theme/theme.dart';
import '../view_model/tv_provider.dart' show tvChannelProvider;
import 'widgets/channel_category.dart';
import 'widgets/premium_mini_card.dart';

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
      body: SafeArea(child: Column(children: [
        _Header(channelCount: channels.length),
        if (premium.isNotEmpty) _PremiumStrip(premium: premium),
        Expanded(child: ListView(padding: EdgeInsets.only(top: 8.h), children: _categories.map((c) {
          final filtered = channels.where((ch) => ch.category == c.$3).toList();
          return ChannelCategory(title: c.$1, icon: c.$2, channels: filtered);
        }).toList())),
      ])),
    );
  }
}

class _Header extends StatelessWidget {
  final int channelCount;
  const _Header({required this.channelCount});

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.fromLTRB(context.padding.p16.r, 12.h, context.padding.p16.r, 4.h),
    child: Row(children: [
      Container(padding: EdgeInsets.all(8.r), decoration: BoxDecoration(
        gradient: LinearGradient(colors: [context.color.primary, context.color.primary.withValues(alpha: 0.6)]),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [BoxShadow(color: context.color.primary.withValues(alpha: 0.25), blurRadius: 8.r, offset: const Offset(0, 3))],
      ), child: FaIcon(FontAwesomeIcons.tv, size: 16, color: Colors.white)),
      12.horizontalSpace,
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('TV Channels', style: context.textStyle.headingMedium.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.3)),
        Row(children: [
          Container(width: 6.r, height: 6.r, decoration: BoxDecoration(
            color: const Color(0xFF00E676), shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: const Color(0xFF00E676).withValues(alpha: 0.5), blurRadius: 4.r)],
          )),
          6.horizontalSpace,
          Text('$channelCount channels available', style: context.textStyle.labelSmall.copyWith(
            color: context.color.text.secondary.withValues(alpha: 0.6),
          )),
        ]),
      ]),
      const Spacer(),
      Container(padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 6.r), decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFFD700), Color(0xFFFFA500)]),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [BoxShadow(color: const Color(0xFFFFD700).withValues(alpha: 0.3), blurRadius: 8.r, offset: const Offset(0, 2))],
      ), child: Row(mainAxisSize: MainAxisSize.min, children: [
        FaIcon(FontAwesomeIcons.crown, size: 10, color: Colors.black87),
        4.horizontalSpace,
        Text('PREMIUM', style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.w700, color: Colors.black87, letterSpacing: 0.5)),
      ])),
    ]),
  );
}

class _PremiumStrip extends StatelessWidget {
  final List premium;
  const _PremiumStrip({required this.premium});

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.fromLTRB(context.padding.p16.r, 12.h, 0, 4.h),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: EdgeInsets.only(right: context.padding.p16.r), child: Row(children: [
        Container(width: 3.r, height: 16.r, decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFFFD700), Color(0xFFFFA500)]),
          borderRadius: BorderRadius.circular(2.r),
        )),
        8.horizontalSpace,
        FaIcon(FontAwesomeIcons.star, size: 13, color: const Color(0xFFFFD700)),
        6.horizontalSpace,
        Text('Premium Channels', style: context.textStyle.labelLarge.copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.3)),
        const Spacer(),
        Text('${premium.length} channels', style: context.textStyle.labelSmall.copyWith(
          fontSize: 10.sp, color: context.color.text.secondary.withValues(alpha: 0.5),
        )),
      ])),
      10.verticalSpace,
      SizedBox(height: 112.h, child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: premium.length,
        separatorBuilder: (_, _) => 8.horizontalSpace,
        itemBuilder: (context, index) => PremiumMiniCard(channel: premium[index]),
      )),
    ]),
  );
}
