import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import 'package:go_router/go_router.dart';

import '../../../../../core/routes/route_const.dart';
import '../../../../../core/static/theme/theme.dart';
import '../../../../feature/home/data/model/content_model.dart';
import '../../../../widgets/custom_loading_indicator.dart';
import '../../../../widgets/custom_network_image.dart';

class VideoPlayerScreen extends StatefulWidget {
  final ContentModel content;

  const VideoPlayerScreen({super.key, required this.content});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _isBuffering = false;
  bool _showControls = true;
  double _sliderValue = 0;
  double _bufferedPercent = 0;
  String _currentTime = '0:00';
  String _totalTime = '0:00';

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.content.videoUrl))
          ..initialize()
              .then((_) {
                if (!mounted) return;
                setState(() => _isInitialized = true);
                _controller.play();
                _controller.addListener(_onControllerUpdate);
              })
              .catchError((_) {
                if (!mounted) return;
                setState(() => _isInitialized = true);
              });
  }

  void _onControllerUpdate() {
    if (!_controller.value.isInitialized) return;
    final value = _controller.value;
    final buffered = value.buffered.isNotEmpty
        ? value.buffered.last.end.inMilliseconds / value.duration.inMilliseconds
        : 0.0;
    setState(() {
      _isPlaying = value.isPlaying;
      _isBuffering = value.isBuffering;
      _bufferedPercent = buffered.clamp(0.0, 1.0);
      _sliderValue =
          value.position.inMilliseconds / value.duration.inMilliseconds;
      _currentTime = _formatDuration(value.position);
      _totalTime = _formatDuration(value.duration);
    });
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  void _seekRelative(int seconds) {
    final newPosition = _controller.value.position + Duration(seconds: seconds);
    if (newPosition < Duration.zero) {
      _controller.seekTo(Duration.zero);
    } else if (newPosition > _controller.value.duration) {
      _controller.seekTo(_controller.value.duration);
    } else {
      _controller.seekTo(newPosition);
    }
  }

  void _onSliderChanged(double value) {
    final position = Duration(
      milliseconds: (value * _controller.value.duration.inMilliseconds).round(),
    );
    _controller.seekTo(position);
  }

  void _toggleControls() {
    setState(() => _showControls = !_showControls);
  }

  void _showSettingsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.color.scaffoldBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => _SettingsSheet(controller: _controller),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerUpdate);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recommended = sampleContents
        .where((c) => c.id != widget.content.id)
        .take(6)
        .toList();

    return Scaffold(
      backgroundColor: context.color.scaffoldBackground,
      body: Column(
        children: [
          _buildVideoPlayer(),
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
                          style: context.textStyle.headingSmall,
                        ),
                        6.verticalSpace,
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.r,
                                vertical: 3.r,
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
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            8.horizontalSpace,
                            Icon(
                              Icons.calendar_today,
                              size: 12,
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
                      ],
                    ),
                  ),
                  16.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.padding.p16.r,
                    ),
                    child: Divider(
                      color: context.color.icon.withValues(alpha: 0.15),
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
                        Text(
                          'Recommended',
                          style: context.textStyle.headingSmall,
                        ),
                        const Spacer(),
                        Text(
                          'See All',
                          style: context.textStyle.bodyMedium.copyWith(
                            color: context.color.primary,
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
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: .zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.6,
                          ),
                      itemCount: recommended.length,
                      itemBuilder: (context, index) {
                        final item = recommended[index];
                        return GestureDetector(
                          onTap: () =>
                              context.push(RouteConst.videoPlayer, extra: item),
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: context.color.secondary.withValues(
                                alpha: 0.08,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: context.color.primary.withValues(
                                    alpha: 0.06,
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CustomNetworkImage(
                                    imageUrl: item.thumbnailUrl,
                                    height: double.infinity,
                                    width: double.infinity,
                                    radius: 0,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.r),
                                  child: Text(
                                    item.title,
                                    style: context.textStyle.bodySmall.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
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

  Widget _buildVideoPlayer() {
    return Container(
      color: Colors.black,
      child: AspectRatio(
        aspectRatio: _isInitialized ? _controller.value.aspectRatio : 16 / 9,
        child: Stack(
          children: [
            if (_isInitialized)
              Stack(
                children: [
                  GestureDetector(
                    onTap: _toggleControls,
                    child: VideoPlayer(_controller),
                  ),
                  if (_isBuffering)
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
            if (_showControls) ...[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                      colors: [
                        Colors.black.withValues(alpha: 0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.6),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.r),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Container(
                            padding: EdgeInsets.all(6.r),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.3),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: _showSettingsSheet,
                          icon: Container(
                            padding: EdgeInsets.all(6.r),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.3),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(8.r, 0, 8.r, 4.r),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.r),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(2.r),
                                child: LinearProgressIndicator(
                                  value: _bufferedPercent,
                                  backgroundColor: Colors.white.withValues(
                                    alpha: 0.15,
                                  ),
                                  valueColor: const AlwaysStoppedAnimation(
                                    Colors.white38,
                                  ),
                                  minHeight: 3,
                                ),
                              ),
                            ),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 3,
                                trackShape: const RectangularSliderTrackShape(),
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 6,
                                ),
                                overlayShape: const RoundSliderOverlayShape(
                                  overlayRadius: 12,
                                ),
                                activeTrackColor: Colors.white,
                                inactiveTrackColor: Colors.transparent,
                                thumbColor: Colors.white,
                              ),
                              child: Slider(
                                value: _sliderValue.isNaN ? 0 : _sliderValue,
                                onChanged: _onSliderChanged,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              _currentTime,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              _totalTime,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (_isInitialized)
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => _seekRelative(-10),
                        icon: Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.replay_10,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ),
                      32.horizontalSpace,
                      GestureDetector(
                        onTap: _togglePlayPause,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.25),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                              width: 2,
                            ),
                          ),
                          padding: EdgeInsets.all(14.r),
                          child: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                      32.horizontalSpace,
                      IconButton(
                        onPressed: () => _seekRelative(10),
                        icon: Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.forward_10,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SettingsSheet extends StatefulWidget {
  final VideoPlayerController controller;

  const _SettingsSheet({required this.controller});

  @override
  State<_SettingsSheet> createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<_SettingsSheet> {
  double _selectedSpeed = 1.0;

  final _speeds = [0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
  final _qualities = ['Auto', '1080p', '720p', '480p', '360p'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Playback Speed', style: context.textStyle.headingSmall),
          12.verticalSpace,
          Wrap(
            spacing: 8.r,
            runSpacing: 8.r,
            children: _speeds.map((speed) {
              final isSelected = _selectedSpeed == speed;
              return GestureDetector(
                onTap: () {
                  setState(() => _selectedSpeed = speed);
                  widget.controller.setPlaybackSpeed(speed);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.r,
                    vertical: 8.r,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? context.color.primary
                        : context.color.icon.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    '${speed}x',
                    style: context.textStyle.bodyMedium.copyWith(
                      color: isSelected
                          ? context.color.onPrimary
                          : context.color.text.secondary,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          20.verticalSpace,
          Text('Quality', style: context.textStyle.headingSmall),
          12.verticalSpace,
          Wrap(
            spacing: 8.r,
            runSpacing: 8.r,
            children: _qualities.map((quality) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
                decoration: BoxDecoration(
                  color: quality == 'Auto'
                      ? context.color.primary
                      : context.color.icon.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  quality,
                  style: context.textStyle.bodyMedium.copyWith(
                    color: quality == 'Auto'
                        ? context.color.onPrimary
                        : context.color.text.secondary,
                    fontWeight: quality == 'Auto'
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
              );
            }).toList(),
          ),
          20.verticalSpace,
        ],
      ),
    );
  }
}
