import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/routes/route_const.dart';
import '../../../../../../../core/static/theme/theme.dart';
import '../../../../../../widgets/custom_network_image.dart';
import '../../../../data/model/content_model.dart';
import '../../view_model/home_view_model.dart';

class CarouselSection extends ConsumerStatefulWidget {
  final List<ContentModel> items;

  const CarouselSection({super.key, required this.items});

  @override
  ConsumerState<CarouselSection> createState() => _CarouselSectionState();
}

class _CarouselSectionState extends ConsumerState<CarouselSection> {
  final _pageController = PageController();
  Timer? _autoSlideTimer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      final current = ref.read(carouselPageProvider);
      final next = (current + 1) % widget.items.length;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(carouselPageProvider);

    return Column(
      children: [
        SizedBox(
          height: 280.h,
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              ref.read(carouselPageProvider.notifier).state = index;
              _startAutoSlide();
            },
            children: widget.items.map((item) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.padding.p16.r,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(context.radius.r16.r),
                    boxShadow: [
                      BoxShadow(
                        color: context.color.primary.withValues(alpha: 0.15),
                        blurRadius: 24.r,
                        offset: const Offset(0, 10),
                      ),
                      BoxShadow(
                        color: context.color.primary.withValues(alpha: 0.06),
                        blurRadius: 8.r,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(context.radius.r16.r),
                    child: GestureDetector(
                      onTap: () =>
                          context.push(RouteConst.videoPlayer, extra: item),
                      child: Stack(
                        children: [
                          CustomNetworkImage(
                            imageUrl: item.thumbnailUrl,
                            height: 280,
                            width: double.infinity,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.center,
                                colors: [
                                  Colors.black.withValues(alpha: 0.4),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 140.h,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    context.color.primary.withValues(
                                      alpha: 0.3,
                                    ),
                                    Colors.black.withValues(alpha: 0.85),
                                  ],
                                ),
                              ),
                              padding: EdgeInsets.all(context.padding.p16.r),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: context.textStyle.bodyLarge.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  6.verticalSpace,
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.r,
                                      vertical: 3.r,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha: 0.12,
                                      ),
                                      borderRadius: BorderRadius.circular(4.r),
                                      border: Border.all(
                                        color: Colors.white.withValues(
                                          alpha: 0.08,
                                        ),
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.clock,
                                          size: 8,
                                          color: Colors.white70,
                                        ),
                                        4.horizontalSpace,
                                        Text(
                                          item.duration,
                                          style: context.textStyle.bodySmall
                                              .copyWith(
                                                color: Colors.white70,
                                                fontSize: 10.sp,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  12.verticalSpace,
                                  Container(
                                    width: double.infinity,
                                    height: 44.h,
                                    decoration: BoxDecoration(
                                      color: context.color.primary,
                                      borderRadius: BorderRadius.circular(14.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: context.color.primary
                                              .withValues(alpha: 0.45),
                                          blurRadius: 16.r,
                                          offset: const Offset(0, 5),
                                        ),
                                        BoxShadow(
                                          color: context.color.primary
                                              .withValues(alpha: 0.15),
                                          blurRadius: 4.r,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(14.r),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(
                                          14.r,
                                        ),
                                        onTap: () => context.push(
                                          RouteConst.videoPlayer,
                                          extra: item,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.play,
                                              size: 14,
                                              color: Colors.white,
                                            ),
                                            8.horizontalSpace,
                                            Text(
                                              'Watch Now',
                                              style: context
                                                  .textStyle
                                                  .labelSmall
                                                  .copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 13.sp,
                                                    letterSpacing: 1.2,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        16.verticalSpace,
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              widget.items.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: EdgeInsets.symmetric(horizontal: 3.r),
                width: currentPage == index ? 26.r : 6.r,
                height: 6.r,
                decoration: BoxDecoration(
                  color: currentPage == index
                      ? context.color.primary
                      : context.color.icon.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(3.r),
                  boxShadow: currentPage == index
                      ? [
                          BoxShadow(
                            color: context.color.primary.withValues(
                              alpha: 0.35,
                            ),
                            blurRadius: 5.r,
                            offset: const Offset(0, 1),
                          ),
                        ]
                      : null,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
