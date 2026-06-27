import 'dart:async';

import 'package:flutter_riverpod/legacy.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerState {
  final bool isInitialized;
  final bool isPlaying;
  final bool isBuffering;
  final bool showControls;
  final double sliderValue;
  final double bufferedPercent;
  final String currentTime;
  final String totalTime;
  final bool isFullScreen;

  const VideoPlayerState({
    this.isInitialized = false,
    this.isPlaying = false,
    this.isBuffering = false,
    this.showControls = true,
    this.sliderValue = 0,
    this.bufferedPercent = 0,
    this.currentTime = '0:00',
    this.totalTime = '0:00',
    this.isFullScreen = false,
  });
}

class VideoPlayerNotifier extends StateNotifier<VideoPlayerState> {
  final VideoPlayerController controller;
  Timer? _autoHideTimer;

  VideoPlayerNotifier(this.controller) : super(const VideoPlayerState());

  @override
  void dispose() {
    _autoHideTimer?.cancel();
    super.dispose();
  }

  void onInitialized() {
    state = VideoPlayerState(isInitialized: true, showControls: true);
    controller.play();
    controller.addListener(_onUpdate);
    _startAutoHideTimer();
  }

  void _onUpdate() {
    if (!controller.value.isInitialized) return;
    final value = controller.value;
    final buffered = value.buffered.isNotEmpty
        ? value.buffered.last.end.inMilliseconds / value.duration.inMilliseconds
        : 0.0;
    final hours = value.position.inHours;
    final posMinutes = value.position.inMinutes.remainder(60);
    final posSeconds = value.position.inSeconds.remainder(60);
    final currentTime = hours > 0
        ? '$hours:${posMinutes.toString().padLeft(2, '0')}:${posSeconds.toString().padLeft(2, '0')}'
        : '$posMinutes:${posSeconds.toString().padLeft(2, '0')}';
    final durHours = value.duration.inHours;
    final durMinutes = value.duration.inMinutes.remainder(60);
    final durSeconds = value.duration.inSeconds.remainder(60);
    final totalTime = durHours > 0
        ? '$durHours:${durMinutes.toString().padLeft(2, '0')}:${durSeconds.toString().padLeft(2, '0')}'
        : '$durMinutes:${durSeconds.toString().padLeft(2, '0')}';

    state = VideoPlayerState(
      isInitialized: true,
      isPlaying: value.isPlaying,
      isBuffering: value.isBuffering,
      showControls: state.showControls,
      sliderValue:
          value.position.inMilliseconds / value.duration.inMilliseconds,
      bufferedPercent: buffered.clamp(0.0, 1.0),
      currentTime: currentTime,
      totalTime: totalTime,
      isFullScreen: state.isFullScreen,
    );
  }

  void togglePlayPause() {
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
  }

  void seekRelative(int seconds) {
    final newPosition = controller.value.position + Duration(seconds: seconds);
    if (newPosition < Duration.zero) {
      controller.seekTo(Duration.zero);
    } else if (newPosition > controller.value.duration) {
      controller.seekTo(controller.value.duration);
    } else {
      controller.seekTo(newPosition);
    }
  }

  void seekTo(double value) {
    final position = Duration(
      milliseconds: (value * controller.value.duration.inMilliseconds).round(),
    );
    controller.seekTo(position);
  }

  void _startAutoHideTimer() {
    _autoHideTimer?.cancel();
    _autoHideTimer = Timer(const Duration(seconds: 4), () {
      if (state.showControls) {
        state = VideoPlayerState(
          isInitialized: state.isInitialized,
          isPlaying: state.isPlaying,
          isBuffering: state.isBuffering,
          showControls: false,
          sliderValue: state.sliderValue,
          bufferedPercent: state.bufferedPercent,
          currentTime: state.currentTime,
          totalTime: state.totalTime,
          isFullScreen: state.isFullScreen,
        );
      }
    });
  }

  void resetAutoHideTimer() {
    if (state.showControls) {
      _startAutoHideTimer();
    }
  }

  void toggleControls() {
    final show = !state.showControls;
    state = VideoPlayerState(
      isInitialized: state.isInitialized,
      isPlaying: state.isPlaying,
      isBuffering: state.isBuffering,
      showControls: show,
      sliderValue: state.sliderValue,
      bufferedPercent: state.bufferedPercent,
      currentTime: state.currentTime,
      totalTime: state.totalTime,
      isFullScreen: state.isFullScreen,
    );
    if (show) {
      _startAutoHideTimer();
    } else {
      _autoHideTimer?.cancel();
    }
  }

  void toggleFullScreen() {
    state = VideoPlayerState(
      isInitialized: state.isInitialized,
      isPlaying: state.isPlaying,
      isBuffering: state.isBuffering,
      showControls: true,
      sliderValue: state.sliderValue,
      bufferedPercent: state.bufferedPercent,
      currentTime: state.currentTime,
      totalTime: state.totalTime,
      isFullScreen: !state.isFullScreen,
    );
  }
}

final videoPlayerProvider =
    StateNotifierProvider.family<
      VideoPlayerNotifier,
      VideoPlayerState,
      VideoPlayerController
    >((ref, controller) => VideoPlayerNotifier(controller));
