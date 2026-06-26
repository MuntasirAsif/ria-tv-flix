import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/gen/assets.gen.dart';
import '../../../../../../core/routes/route_const.dart';
import '../../../../../../core/static/theme/theme.dart';
import '../../../../../widgets/custom_network_image.dart';
import '../../../data/model/content_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();
  int _currentPage = 0;
  bool _isSearching = false;
  Timer? _autoSlideTimer;

  final _featuredItems = sampleContents.take(5).toList();

  final _categories = const [
    ('Top Rating Originals', 'original'),
    ('Trending Music', 'music'),
    ('Action Movies', 'action'),
    ('Bangla Movies', 'bangla'),
    ('Romantic Movies', 'romantic'),
    ('Bangla Natok', 'natok'),
    ('Sports Heights', 'sports'),
    ('Cartoon Videos', 'cartoon'),
  ];

  List<Widget> _categorySections(BuildContext context) {
    return _categories.map((category) {
      final items = sampleContents
          .where((c) => c.category == category.$2)
          .toList();
      if (items.isEmpty) return const SizedBox();

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
                      color: context.color.primary,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: Text(
                      category.$1,
                      style: context.textStyle.headingSmall.copyWith(
                        letterSpacing: 0.5,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  12.horizontalSpace,
                  GestureDetector(
                    onTap: () => context.go(RouteConst.categoriesScreen),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.r,
                        vertical: 4.r,
                      ),
                      decoration: BoxDecoration(
                        color: context.color.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: context.color.primary.withValues(alpha: 0.15),
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'See All',
                            style: context.textStyle.bodyMedium.copyWith(
                              color: context.color.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 11.sp,
                            ),
                          ),
                          4.horizontalSpace,
                          FaIcon(
                            FontAwesomeIcons.chevronRight,
                            size: 8,
                            color: context.color.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            14.verticalSpace,
            SizedBox(
              height: 175.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                padding: EdgeInsets.only(right: context.padding.p16.r),
                separatorBuilder: (_, _) => 10.horizontalSpace,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return GestureDetector(
                    onTap: () =>
                        context.push(RouteConst.videoPlayer, extra: item),
                    child: SizedBox(
                      width: 110.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.r),
                              boxShadow: [
                                BoxShadow(
                                  color: context.color.primary.withValues(
                                    alpha: 0.12,
                                  ),
                                  blurRadius: 14.r,
                                  offset: const Offset(0, 6),
                                ),
                                BoxShadow(
                                  color: context.color.primary.withValues(
                                    alpha: 0.05,
                                  ),
                                  blurRadius: 4.r,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14.r),
                              child: Stack(
                                children: [
                                  CustomNetworkImage(
                                    imageUrl: item.thumbnailUrl,
                                    height: 155,
                                    width: 110,
                                    radius: 0,
                                  ),
                                  Container(
                                    height: 155,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withValues(alpha: 0.55),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 6.r,
                                    bottom: 6.r,
                                    child: Container(
                                      padding: EdgeInsets.all(7.r),
                                      decoration: BoxDecoration(
                                        color: context.color.primary,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: context.color.primary
                                                .withValues(alpha: 0.4),
                                            blurRadius: 8.r,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: FaIcon(
                                        FontAwesomeIcons.play,
                                        size: 11,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          8.verticalSpace,
                          Text(
                            item.title,
                            style: context.textStyle.bodySmall.copyWith(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      final nextPage = (_currentPage + 1) % _featuredItems.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  void _onSearch() {
    setState(() => _isSearching = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  void _onCloseSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });
    _searchFocusNode.unfocus();
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: _isSearching
              ? Padding(
                  key: const ValueKey('search'),
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Container(
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: context.color.scaffoldBackground,
                      borderRadius: BorderRadius.circular(context.radius.r12.r),
                      border: Border.all(
                        color: context.color.primary.withValues(alpha: 0.1),
                        width: 0.5,
                      ),
                    ),
                    child: TextField(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Search movies, shows...',
                        hintStyle: context.textStyle.bodyMedium.copyWith(
                          color: context.color.icon.withValues(alpha: 0.4),
                          fontStyle: FontStyle.italic,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: context.color.primary.withValues(
                              alpha: 0.15,
                            ),
                            width: 0.5,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: context.color.primary,
                            width: 0.5,
                          ),
                        ),
                        prefixIcon: Container(
                          height: 22.h,
                          width: 22.w,
                          alignment: .center,
                          margin: EdgeInsets.all(5.r),
                          decoration: BoxDecoration(
                            color: context.color.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(
                              context.radius.r10.r,
                            ),
                          ),
                          child: FaIcon(
                            FontAwesomeIcons.magnifyingGlass,
                            color: context.color.primary,
                            size: 15,
                          ),
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? Container(
                                margin: EdgeInsets.all(10.r),
                                decoration: BoxDecoration(
                                  color: context.color.icon.withValues(
                                    alpha: 0.08,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    context.radius.r10.r,
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() {});
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.xmark,
                                    size: 13,
                                    color: context.color.icon,
                                  ),
                                  splashRadius: 16,
                                ),
                              )
                            : null,
                        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      style: context.textStyle.bodyMedium.copyWith(height: 1.3),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                )
              : Padding(
                  key: const ValueKey('logo'),
                  padding: EdgeInsets.only(top: 4.h),
                  child: Assets.images.appLogoCom.image(height: 52.h),
                ),
        ),
        leading: _isSearching
            ? IconButton(
                onPressed: _onCloseSearch,
                icon: Icon(Icons.arrow_back, color: context.color.icon),
              )
            : null,
        actions: [
          if (!_isSearching)
            Padding(
              padding: EdgeInsets.only(right: 4.r),
              child: IconButton(
                onPressed: _onSearch,
                icon: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: context.color.icon.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: context.color.icon.withValues(alpha: 0.1),
                      width: 0.5,
                    ),
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 16,
                    color: context.color.icon,
                  ),
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.only(right: 4.r),
            child: IconButton(
              onPressed: () {},
              icon: Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: context.color.icon.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: context.color.icon.withValues(alpha: 0.1),
                    width: 0.5,
                  ),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.bell,
                      size: 16,
                      color: context.color.icon,
                    ),
                    Positioned(
                      right: -3,
                      top: -3,
                      child: Container(
                        width: 7.r,
                        height: 7.r,
                        decoration: BoxDecoration(
                          color: context.color.error,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 280.h,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                  _startAutoSlide();
                },
                children: _featuredItems.map((item) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.padding.p16.r,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          context.radius.r16.r,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: context.color.primary.withValues(
                              alpha: 0.15,
                            ),
                            blurRadius: 24.r,
                            offset: const Offset(0, 10),
                          ),
                          BoxShadow(
                            color: context.color.primary.withValues(
                              alpha: 0.06,
                            ),
                            blurRadius: 8.r,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          context.radius.r16.r,
                        ),
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
                                  padding: EdgeInsets.all(
                                    context.padding.p16.r,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title,
                                        style: context.textStyle.bodyLarge
                                            .copyWith(
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
                                          borderRadius: BorderRadius.circular(
                                            4.r,
                                          ),
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
                                          borderRadius: BorderRadius.circular(
                                            14.r,
                                          ),
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
                                          borderRadius: BorderRadius.circular(
                                            14.r,
                                          ),
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
                                                        fontWeight:
                                                            FontWeight.w700,
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
                  _featuredItems.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.symmetric(horizontal: 3.r),
                    width: _currentPage == index ? 26.r : 6.r,
                    height: 6.r,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? context.color.primary
                          : context.color.icon.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(3.r),
                      boxShadow: _currentPage == index
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
            24.verticalSpace,
            ..._categorySections(context),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
