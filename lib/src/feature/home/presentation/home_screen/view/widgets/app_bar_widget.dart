import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../core/gen/assets.gen.dart';
import '../../../../../../../core/static/theme/theme.dart';
import '../../view_model/home_view_model.dart';
import 'search_bar_widget.dart';

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearching = ref.watch(isSearchingProvider);

    return AppBar(
      backgroundColor: Colors.transparent,
      title: isSearching
          ? const HomeSearchBar()
          : Padding(
              key: const ValueKey('logo'),
              padding: EdgeInsets.only(top: 4.h),
              child: Assets.images.appLogoCom.image(height: 52.h),
            ),
      leading: isSearching
          ? IconButton(
              onPressed: () {
                ref.read(isSearchingProvider.notifier).state = false;
                ref.read(searchTextProvider.notifier).state = '';
              },
              icon: Icon(Icons.arrow_back, color: context.color.icon),
            )
          : null,
      actions: [
        if (!isSearching)
          Padding(
            padding: EdgeInsets.only(right: 4.r),
            child: IconButton(
              onPressed: () {
                ref.read(isSearchingProvider.notifier).state = true;
              },
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
    );
  }
}
