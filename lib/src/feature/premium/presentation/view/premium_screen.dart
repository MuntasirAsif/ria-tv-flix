import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/static/theme/theme.dart';
import '../view_model/premium_provider.dart'
    show premiumPlansProvider, premiumContentProvider;
import 'widgets/content_card.dart';
import 'widgets/plan_button.dart';
import 'widgets/premium_feature.dart';
import 'widgets/premium_header.dart';
import 'widgets/subscription_card.dart';

class PremiumScreen extends ConsumerStatefulWidget {
  const PremiumScreen({super.key});

  @override
  ConsumerState<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends ConsumerState<PremiumScreen> {
  final _scrollController = ScrollController();
  final _scrollNotifier = ValueNotifier<double>(0);

  static const _features = [
    (
      FontAwesomeIcons.gem,
      'Exclusive Content',
      'Access premium movies, series & channels',
    ),
    (
      FontAwesomeIcons.wifi,
      'Ad-Free Experience',
      'Enjoy uninterrupted streaming',
    ),
    (
      FontAwesomeIcons.clapperboard,
      '4K + HDR Quality',
      'Crystal clear ultra HD streaming',
    ),
    (
      FontAwesomeIcons.clapperboard,
      'Early Access',
      'Watch new movies & shows first',
    ),
  ];

  double _progress(double offset) => (offset / 200).clamp(0.0, 1.0);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _scrollNotifier.value = _scrollController.offset;
    });
  }

  @override
  void dispose() {
    _scrollNotifier.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final plans = ref.watch(premiumPlansProvider);
    final contents = ref.watch(premiumContentProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.only(top: 160.h, bottom: 100.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.padding.p16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.verticalSpace,
                  _sectionTitle(
                    context,
                    'Subscription Plans',
                  ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2),
                  12.verticalSpace,
                  ListenableBuilder(
                    listenable: _scrollNotifier,
                    builder: (_, _) {
                      final e = _progress(_scrollNotifier.value);
                      return Column(
                        children: [
                          SizedBox(
                            child: Opacity(
                              opacity: 1 - e,
                              child: Transform.translate(
                                offset: Offset(0, -e * 200),
                                child: SubscriptionCard(plan: plans[2]),
                              ),
                            ),
                          ),
                          12.verticalSpace,
                          SizedBox(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Opacity(
                                    opacity: 1 - e,
                                    child: Transform.translate(
                                      offset: Offset(-e * 200, 0),
                                      child: SubscriptionCard(plan: plans[0]),
                                    ),
                                  ),
                                ),
                                12.horizontalSpace,
                                Expanded(
                                  child: Opacity(
                                    opacity: 1 - e,
                                    child: Transform.translate(
                                      offset: Offset(e * 200, 0),
                                      child: SubscriptionCard(plan: plans[1]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  28.verticalSpace,
                  _sectionTitle(
                    context,
                    'Premium Contents',
                  ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2),
                  12.verticalSpace,
                  SizedBox(
                    height: 180.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: contents.length,
                      padding: EdgeInsets.only(right: context.padding.p16.r),
                      separatorBuilder: (_, _) => 10.horizontalSpace,
                      itemBuilder: (_, i) => ContentCard(content: contents[i])
                          .animate(delay: (i * 80).ms)
                          .fadeIn(duration: 400.ms)
                          .slideY(begin: 0.3),
                    ),
                  ),
                  28.verticalSpace,
                  _sectionTitle(
                    context,
                    'Why Go Premium?',
                  ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2),
                  12.verticalSpace,
                  ..._features.asMap().entries.map(
                    (e) =>
                        Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: PremiumFeature(
                                icon: e.value.$1,
                                title: e.value.$2,
                                description: e.value.$3,
                              ),
                            )
                            .animate(delay: (e.key * 60).ms)
                            .fadeIn(duration: 400.ms)
                            .slideY(begin: 0.2),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ListenableBuilder(
              listenable: _scrollNotifier,
              builder: (_, child) {
                final o = _scrollNotifier.value;
                final t = _progress(o);
                return Opacity(
                  opacity: 1 - t,
                  child: Transform.translate(
                    offset: Offset(0, -o * 0.5),
                    child: Transform.scale(
                      scale: 1 - t * 0.1,
                      alignment: Alignment.center,
                      child: child,
                    ),
                  ),
                );
              },
              child: const PremiumHeader()
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: -0.2),
            ),
          ),
          ListenableBuilder(
            listenable: _scrollNotifier,
            builder: (_, _) {
              final t = _progress(_scrollNotifier.value);
              return Opacity(
                opacity: t,
                child: Container(
                  padding: EdgeInsets.only(top: 48.h),
                  height: 88.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        context.color.primary,
                        context.color.primary.withValues(alpha: 0.95),
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      16.horizontalSpace,
                      Text(
                        'Premium',
                        style: context.textStyle.headingMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          ListenableBuilder(
            listenable: _scrollNotifier,
            builder: (_, _) {
              final f = _progress(_scrollNotifier.value);
              return Positioned(
                bottom: 24.h + (1 - f) * 80,
                left: context.padding.p16.r,
                right: context.padding.p16.r,
                child: Opacity(
                  opacity: f,
                  child: Row(
                    children: [
                      Expanded(
                        child: PlanButton(
                          label: 'Current Plan',
                          onTap: () {},
                          outlined: true,
                        ),
                      ),
                      12.horizontalSpace,
                      Expanded(
                        child: PlanButton(
                          label: 'Upgrade',
                          onTap: () {},
                          gold: true,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: context.textStyle.headingSmall.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
