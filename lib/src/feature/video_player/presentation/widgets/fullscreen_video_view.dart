import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../../../widgets/custom_loading_indicator.dart';
import '../view_model/video_player_view_model.dart';
import 'video_overlay.dart';

class FullscreenVideoView extends StatelessWidget {
  final VideoPlayerController controller;
  final VideoPlayerState state;
  final VideoPlayerNotifier notifier;
  final VoidCallback onFullScreenToggle;

  const FullscreenVideoView({
    super.key,
    required this.controller,
    required this.state,
    required this.notifier,
    required this.onFullScreenToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
          children: [
            Center(
              child: FractionallySizedBox(
                widthFactor: 0.85,
                child: state.isInitialized
                    ? GestureDetector(
                        onTap: () => notifier.toggleControls(),
                        child: VideoPlayer(controller),
                      )
                    : const CustomLoadingIndicator(),
              ),
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
            if (state.showControls)
              VideoOverlay(
                state: state,
                notifier: notifier,
                onFullScreenToggle: onFullScreenToggle,
                onBackPressed: onFullScreenToggle,
                isFullScreen: true,
              ),
          ],
      ),
    );
  }
}
