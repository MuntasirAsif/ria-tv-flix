import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/static/theme/theme.dart';
import '../view_model/tv_provider.dart' show TvChannel, tvChannelProvider;
import 'widgets/channel_category.dart';
import 'widgets/tv_header.dart';
import 'widgets/tv_premium_strip.dart';

class TvScreen extends ConsumerStatefulWidget {
  const TvScreen({super.key});

  @override
  ConsumerState<TvScreen> createState() => _TvScreenState();
}

class _TvScreenState extends ConsumerState<TvScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  static const _categories = [
    ('All', FontAwesomeIcons.thLarge, null),
    ('News', FontAwesomeIcons.newspaper, 'news'),
    ('Sports', FontAwesomeIcons.baseball, 'sports'),
    ('Entertainment', FontAwesomeIcons.tv, 'entertainment'),
    ('Music', FontAwesomeIcons.music, 'music'),
    ('Kids', FontAwesomeIcons.child, 'kids'),
    ('Documentary', FontAwesomeIcons.globe, 'documentary'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final channels = ref.watch(tvChannelProvider);
    final premium = channels.where((c) => c.isPremium).toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            TvHeader(
              channelCount: channels.length,
            ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.2),
            if (premium.isNotEmpty) ...[
              10.verticalSpace,
              TvPremiumStrip(
                premium: premium,
              ).animate(delay: 200.ms).fadeIn().slideX(begin: -0.2),
              20.verticalSpace,
            ],
            TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              padding: EdgeInsets.symmetric(horizontal: context.padding.p16.r),
              labelPadding: EdgeInsets.symmetric(horizontal: 6.w),
              indicatorSize: TabBarIndicatorSize.label,
              dividerColor: Colors.transparent,
              labelStyle: context.textStyle.labelMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: context.textStyle.labelMedium.copyWith(
                fontWeight: FontWeight.w400,
              ),
              tabs: _categories.map((c) => Tab(text: c.$1)).toList(),
            ),
            20.verticalSpace,
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: _categories.map((c) {
                  final filtered = c.$3 == null
                      ? channels
                      : channels.where((ch) => ch.category == c.$3).toList();
                  final grouped = <String, List<TvChannel>>{};
                  for (final ch in filtered) {
                    grouped
                        .putIfAbsent(ch.category, () => <TvChannel>[])
                        .add(ch);
                  }
                  final catMap = <String, (String, FaIconData)>{
                    'news': ('News', FontAwesomeIcons.newspaper),
                    'sports': ('Sports', FontAwesomeIcons.baseball),
                    'entertainment': ('Entertainment', FontAwesomeIcons.tv),
                    'music': ('Music', FontAwesomeIcons.music),
                    'kids': ('Kids', FontAwesomeIcons.child),
                    'documentary': ('Documentary', FontAwesomeIcons.globe),
                  };
                  final entries = grouped.entries.toList();
                  return ListView(
                    padding: EdgeInsets.only(top: 8.h),
                    children: entries.asMap().entries.map((e) {
                      final group = e.value;
                      final meta =
                          catMap[group.key] ??
                          (group.key, FontAwesomeIcons.question);
                      return ChannelCategory(
                            title: meta.$1,
                            icon: meta.$2,
                            channels: group.value,
                          )
                          .animate(delay: (e.key * 80).ms)
                          .fadeIn(duration: 400.ms)
                          .slideY(begin: 0.2);
                    }).toList(),
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
