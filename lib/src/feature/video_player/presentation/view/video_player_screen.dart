import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/static/theme/theme.dart';
import '../../../../feature/home/data/model/content_model.dart';
import '../../../../widgets/custom_loading_indicator.dart';
import '../view_model/video_player_view_model.dart';
import '../widgets/recommended_grid.dart';
import '../widgets/video_overlay.dart';

class VideoPlayerScreen extends ConsumerStatefulWidget {
  final ContentModel content;

  const VideoPlayerScreen({super.key, required this.content});

  @override
  ConsumerState<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends ConsumerState<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.content.videoUrl),
    );
    _controller
        .initialize()
        .then((_) {
          if (!mounted) return;
          ref.read(videoPlayerProvider(_controller).notifier).onInitialized();
        })
        .catchError((_) {
          if (!mounted) return;
          ref.read(videoPlayerProvider(_controller).notifier).onInitialized();
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(videoPlayerProvider(_controller));
    final notifier = ref.read(videoPlayerProvider(_controller).notifier);

    final recommended = sampleContents
        .where((c) => c.id != widget.content.id)
        .take(6)
        .toList();

    return Scaffold(
      backgroundColor: context.color.scaffoldBackground,
      body: Column(
        children: [
          Container(
            color: Colors.black,
            child: AspectRatio(
              aspectRatio: state.isInitialized
                  ? _controller.value.aspectRatio
                  : 16 / 9,
              child: Stack(
                children: [
                  if (state.isInitialized)
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () => notifier.toggleControls(),
                          child: VideoPlayer(_controller),
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
                    VideoOverlay(state: state, notifier: notifier),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
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
                          widget.content.title,
                          style: context.textStyle.headingSmall.copyWith(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                        ),
                        8.verticalSpace,
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.r,
                                vertical: 4.r,
                              ),
                              decoration: BoxDecoration(
                                color: context.color.primary.withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                widget.content.category,
                                style: context.textStyle.bodySmall.copyWith(
                                  color: context.color.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            8.horizontalSpace,
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.r,
                                vertical: 4.r,
                              ),
                              decoration: BoxDecoration(
                                color: context.color.icon.withValues(
                                  alpha: 0.06,
                                ),
                                borderRadius: BorderRadius.circular(4.r),
                                border: Border.all(
                                  color: context.color.icon.withValues(
                                    alpha: 0.1,
                                  ),
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
                                    widget.content.publishDate,
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
                  ),
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.padding.p16.r,
                    ),
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
                          style: context.textStyle.headingSmall.copyWith(
                            letterSpacing: 0.3,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.r,
                            vertical: 4.r,
                          ),
                          decoration: BoxDecoration(
                            color: context.color.primary.withValues(
                              alpha: 0.08,
                            ),
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: context.color.primary.withValues(
                                alpha: 0.15,
                              ),
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
                  ),
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
      ),
    );
  }
}
