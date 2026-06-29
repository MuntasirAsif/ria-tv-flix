import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/static/theme/theme.dart';
import '../view_model/premium_provider.dart'
    show premiumPlansProvider, premiumContentProvider;
import 'widgets/content_card.dart';
import 'widgets/premium_feature.dart';
import 'widgets/premium_header.dart';
import 'widgets/subscription_card.dart';

class PremiumScreen extends ConsumerWidget {
  const PremiumScreen({super.key});

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
      FontAwesomeIcons.download,
      'Offline Download',
      'Download and watch anywhere, anytime',
    ),
    (
      FontAwesomeIcons.users,
      'Family Sharing',
      'Share with up to 4 family members',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plans = ref.watch(premiumPlansProvider);
    final contents = ref.watch(premiumContentProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 24.h),
        child: Column(
          children: [
            const PremiumHeader(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.padding.p16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.verticalSpace,
                  _sectionTitle(context, 'Subscription Plans'),
                  12.verticalSpace,
                  SizedBox(
                    height: 280.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: plans.length,
                      padding: EdgeInsets.only(right: context.padding.p16.r),
                      separatorBuilder: (_, _) => 12.horizontalSpace,
                      itemBuilder: (_, i) => SubscriptionCard(plan: plans[i]),
                    ),
                  ),
                  28.verticalSpace,
                  _sectionTitle(context, 'Premium Contents'),
                  12.verticalSpace,
                  SizedBox(
                    height: 180.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: contents.length,
                      padding: EdgeInsets.only(right: context.padding.p16.r),
                      separatorBuilder: (_, _) => 10.horizontalSpace,
                      itemBuilder: (_, i) => ContentCard(content: contents[i]),
                    ),
                  ),
                  28.verticalSpace,
                  _sectionTitle(context, 'Why Go Premium?'),
                  12.verticalSpace,
                  ..._features.map(
                    (f) => Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: PremiumFeature(
                        icon: f.$1,
                        title: f.$2,
                        description: f.$3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
