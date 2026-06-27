import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/static/theme/theme.dart';
import '../view_model/video_player_view_model.dart';

class VideoOverlay extends StatelessWidget {
  final VideoPlayerState state;
  final VideoPlayerNotifier notifier;
  final VoidCallback? onFullScreenToggle;
  final VoidCallback? onBackPressed;

  const VideoOverlay({
    super.key,
    required this.state,
    required this.notifier,
    this.onFullScreenToggle,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            padding: EdgeInsets.all(16.r),
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
              padding: EdgeInsets.symmetric(horizontal: 8.r),
              child: Row(
                children: [
                  IconButton(
                    onPressed: onBackPressed ?? () => Navigator.pop(context),
                    icon: Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.15),
                          width: 0.5,
                        ),
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.arrowLeft,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      notifier.resetAutoHideTimer();
                      _showSettings(context);
                    },
                    icon: Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.15),
                          width: 0.5,
                        ),
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.gear,
                        color: Colors.white,
                        size: 18,
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
                  _buildSlider(context),
                  Row(
                    children: [
                      Text(
                        state.currentTime,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        state.totalTime,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      8.horizontalSpace,
                      GestureDetector(
                        onTap: () {
                          notifier.resetAutoHideTimer();
                          onFullScreenToggle?.call();
                        },
                        child: Icon(
                          Icons.fullscreen,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (state.isInitialized)
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    notifier.resetAutoHideTimer();
                    notifier.seekRelative(-10);
                  },
                  icon: Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                        width: 0.5,
                      ),
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.rotateLeft,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
                24.horizontalSpace,
                GestureDetector(
                  onTap: () {
                    notifier.resetAutoHideTimer();
                    notifier.togglePlayPause();
                  },
                  child: Container(
                    width: 60.r,
                    height: 60.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.color.primary,
                      boxShadow: [
                        BoxShadow(
                          color: context.color.primary.withValues(alpha: 0.4),
                          blurRadius: 12.r,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      state.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
                24.horizontalSpace,
                IconButton(
                  onPressed: () {
                    notifier.resetAutoHideTimer();
                    notifier.seekRelative(10);
                  },
                  icon: Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                        width: 0.5,
                      ),
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.rotateRight,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildSlider(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.r),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2.r),
            child: LinearProgressIndicator(
              value: state.bufferedPercent,
              backgroundColor: Colors.white.withValues(alpha: 0.15),
              valueColor: const AlwaysStoppedAnimation(Colors.white38),
              minHeight: 3,
            ),
          ),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 3,
            trackShape: const RectangularSliderTrackShape(),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
            activeTrackColor: Colors.white,
            inactiveTrackColor: Colors.transparent,
            thumbColor: Colors.white,
          ),
          child: Slider(
            value: state.sliderValue.isNaN ? 0 : state.sliderValue,
            onChanged: (v) {
              notifier.resetAutoHideTimer();
              notifier.seekTo(v);
            },
          ),
        ),
      ],
    );
  }

  void _showSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.color.scaffoldBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => const _SettingsSheet(),
    );
  }
}

class _SettingsSheet extends StatefulWidget {
  const _SettingsSheet();

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
                onTap: () => setState(() => _selectedSpeed = speed),
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
