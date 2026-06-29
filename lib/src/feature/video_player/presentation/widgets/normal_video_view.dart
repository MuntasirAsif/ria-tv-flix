import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/static/theme/theme.dart';
import '../../../home/data/model/content_model.dart';
import '../../../../widgets/custom_loading_indicator.dart';
import '../view_model/video_player_view_model.dart';
import 'recommended_grid.dart';
import 'video_overlay.dart';

class NormalVideoView extends StatelessWidget {
  final VideoPlayerController controller;
  final VideoPlayerState state;
  final VideoPlayerNotifier notifier;
  final ContentModel content;
  final VoidCallback onFullScreenToggle;
  final List<ContentModel> recommended;

  const NormalVideoView({
    super.key,
    required this.controller,
    required this.state,
    required this.notifier,
    required this.content,
    required this.onFullScreenToggle,
    required this.recommended,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.scaffoldBackground,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final videoHeight =
              constraints.maxWidth *
              (state.isInitialized
                  ? (1 / controller.value.aspectRatio)
                  : 9 / 16);
          return Column(
            children: [
              SizedBox(
                width: constraints.maxWidth,
                height: videoHeight,
                child: _buildPlayerContent(context),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoSection(context),
                      16.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.padding.p16.r,
                        ),
                        child: Divider(
                          color: context.color.icon.withValues(alpha: 0.12),
                          height: 1,
                        ),
                      ),
                      16.verticalSpace,
                      _buildRecommendedHeader(context),
                      16.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.padding.p16.r,
                        ),
                        child: RecommendedGrid(items: recommended),
                      ),
                      24.verticalSpace,
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPlayerContent(BuildContext context) {
    return Stack(
      children: [
        if (state.isInitialized)
          Stack(
            children: [
              GestureDetector(
                onTap: () => notifier.toggleControls(),
                child: VideoPlayer(controller),
              ),
              if (state.isBuffering)
                Positioned(
                  right: 16.r,
                  bottom: 60.h,
                  child: SizedBox(
                    width: 20.r,
                    height: 20.r,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ),
            ],
          )
        else
          const CustomLoadingIndicator(),
        if (state.showControls)
          VideoOverlay(
            state: state,
            notifier: notifier,
            onFullScreenToggle: onFullScreenToggle,
          ),
      ],
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.padding.p16.r,
        context.padding.p16.r,
        context.padding.p16.r,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content.title,
            style: context.textStyle.headingSmall.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
          8.verticalSpace,
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
                decoration: BoxDecoration(
                  color: context.color.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  content.category,
                  style: context.textStyle.bodySmall.copyWith(
                    color: context.color.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              8.horizontalSpace,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
                decoration: BoxDecoration(
                  color: context.color.icon.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(
                    color: context.color.icon.withValues(alpha: 0.1),
                    width: 0.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.calendarDays,
                      size: 10,
                      color: context.color.icon,
                    ),
                    4.horizontalSpace,
                    Text(
                      content.publishDate,
                      style: context.textStyle.bodySmall.copyWith(
                        color: context.color.icon,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.padding.p16.r),
      child: Row(
        children: [
          Container(
            width: 3.r,
            height: 16.r,
            decoration: BoxDecoration(
              color: context.color.primary,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          8.horizontalSpace,
          Text(
            'Recommended',
            style: context.textStyle.headingSmall.copyWith(letterSpacing: 0.3),
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 4.r),
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
        ],
      ),
    );
  }
}
