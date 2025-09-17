import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String path;
  final bool trialler;

  const VideoPlayerScreen({
    super.key,
    required this.trialler,
    required this.path,
  });
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  BetterPlayerController? _betterPlayerController;

  @override
  void initState() {
    super.initState();
    _setupVideoPlayer();
  }

  void _setupVideoPlayer() {
    final betterPlayerDataSource = BetterPlayerDataSource(
      cacheConfiguration: BetterPlayerCacheConfiguration(useCache: true),
      BetterPlayerDataSourceType.network,
      widget.path,
      useAsmsSubtitles: true,
      useAsmsTracks: true,
    );

    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        aspectRatio: 16 / 9,
        fit: BoxFit.contain,
        autoPlay: true,
        errorBuilder: (context, errorMessage) =>
            Center(child: CircularProgressIndicator()),
        controlsConfiguration: BetterPlayerControlsConfiguration(
          progressBarPlayedColor: Colors.red,
          enableProgressBarDrag: true,
          enableProgressText: true,
          enableProgressBar: true,
          enableSubtitles: true,
          enableQualities: false,
          showControls: true,
          enableAudioTracks: true,
          enableFullscreen: false,
        ),
      ),
      betterPlayerDataSource: betterPlayerDataSource,
    );
  }

  @override
  void dispose() {
    _betterPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (widget.trialler) {
        _betterPlayerController!.pause();
      }
      _betterPlayerController!.play();
    });
    return _betterPlayerController != null
        ? BetterPlayer(controller: _betterPlayerController!)
        : const Center(child: CircularProgressIndicator());
  }
}
