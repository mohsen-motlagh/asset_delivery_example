import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlaySoundsPage extends StatefulWidget {
  final String assetPackPath;
  const PlaySoundsPage({super.key, required this.assetPackPath});

  @override
  State<PlaySoundsPage> createState() => _PlaySoundsPageState();
}

class _PlaySoundsPageState extends State<PlaySoundsPage> {
  final player = AudioPlayer();

  @override
  void initState() {
    if (Platform.isAndroid) {
      player.setFilePath('${widget.assetPackPath}/sounds/sound1.mp3');
    } else if (Platform.isIOS) {
      final actualPath = Uri.parse(widget.assetPackPath).toFilePath();
      _init('$actualPath/sound1.mp3');
      player.setFilePath('$actualPath/sound1.mp3');
      // you can also access other sounds by changing the sound1.mp3 to sound2.mp3, sound3.mp3, sound4.mp3
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Play sounds'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                player.play();
              },
              child: Icon(Icons.play_arrow),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                player.pause();
              },
              child: Icon(Icons.pause)),
        ],
      ),
    );
  }

  void _init(String path) async {
    final check = await File(path).exists();
    print('check ====== $check');
  }
}
