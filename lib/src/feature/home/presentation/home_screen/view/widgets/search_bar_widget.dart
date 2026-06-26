import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../core/static/theme/theme.dart';
import '../../view_model/home_view_model.dart';

class HomeSearchBar extends ConsumerStatefulWidget {
  const HomeSearchBar({super.key});

  @override
  ConsumerState<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends ConsumerState<HomeSearchBar> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _focusNode.requestFocus(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          controller: _controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: 'Search movies, shows...',
            hintStyle: context.textStyle.bodyMedium.copyWith(
              color: context.color.icon.withValues(alpha: 0.4),
              fontStyle: FontStyle.italic,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.color.primary.withValues(alpha: 0.15),
                width: 0.5,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: context.color.primary, width: 0.5),
            ),
            prefixIcon: Container(
              height: 22.h,
              width: 22.w,
              alignment: Alignment.center,
              margin: EdgeInsets.all(5.r),
              decoration: BoxDecoration(
                color: context.color.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(context.radius.r10.r),
              ),
              child: FaIcon(
                FontAwesomeIcons.magnifyingGlass,
                color: context.color.primary,
                size: 15,
              ),
            ),
            suffixIcon: _controller.text.isNotEmpty
                ? Container(
                    margin: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: context.color.icon.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(context.radius.r10.r),
                    ),
                    child: IconButton(
                      onPressed: () {
                        _controller.clear();
                        ref.read(searchTextProvider.notifier).state = '';
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
          onChanged: (v) => ref.read(searchTextProvider.notifier).state = v,
        ),
      ),
    );
  }
}
