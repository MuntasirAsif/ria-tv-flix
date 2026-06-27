import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../../../feature/home/data/model/content_model.dart';
import '../view_model/video_player_view_model.dart';
import '../widgets/fullscreen_video_view.dart';
import '../widgets/normal_video_view.dart';

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

  void _enterFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void _exitFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  void _handleFullScreenToggle() {
    final currentState = ref.read(videoPlayerProvider(_controller));
    final notifier = ref.read(videoPlayerProvider(_controller).notifier);
    if (currentState.isFullScreen) {
      _exitFullScreen();
    } else {
      _enterFullScreen();
    }
    notifier.toggleFullScreen();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(videoPlayerProvider(_controller));
    final notifier = ref.read(videoPlayerProvider(_controller).notifier);

    if (state.isFullScreen) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          if (state.isFullScreen) {
            _exitFullScreen();
            notifier.toggleFullScreen();
          }
        },
        child: FullscreenVideoView(
          controller: _controller,
          state: state,
          notifier: notifier,
          onFullScreenToggle: _handleFullScreenToggle,
        ),
      );
    }

    final recommended = sampleContents
        .where((c) => c.id != widget.content.id)
        .take(6)
        .toList();

    return NormalVideoView(
      controller: _controller,
      state: state,
      notifier: notifier,
      content: widget.content,
      onFullScreenToggle: _handleFullScreenToggle,
      recommended: recommended,
    );
  }
}
