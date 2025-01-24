import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayVideoPage extends StatefulWidget {
  final String assetPackPath;
  const PlayVideoPage({super.key, required this.assetPackPath});

  @override
  State<PlayVideoPage> createState() => _PlayVideoPageState();
}

class _PlayVideoPageState extends State<PlayVideoPage> {
  late VideoPlayerController _controller;
  String? path;

  @override
  void initState() {
    print('path === ${widget.assetPackPath}');
    if (Platform.isAndroid) {
      path = '${widget.assetPackPath}/video/video1.mp4';
    } else if (Platform.isIOS) {
      path = '${Uri.parse(widget.assetPackPath).toFilePath()}video1.mp4';
    }
    _init();
    print('path ==22222= ${File(path!).existsSync()}');
    _controller = VideoPlayerController.file(File(path!))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    _controller.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Play Video'),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying ? _controller.pause() : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  void _init() async {
    print(' 4564879646 path == $path');
    final check = await File(path!).exists();
    print('check ====== $check');
  }
}
