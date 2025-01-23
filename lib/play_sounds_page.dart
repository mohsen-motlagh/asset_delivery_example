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
    print('the file path from package ${widget.assetPackPath}');
    print(File('${widget.assetPackPath}/sound1.mp3').existsSync());
    if (Platform.isAndroid) {
      player.setFilePath('${widget.assetPackPath}/sound1.mp3');
    } else if (Platform.isIOS) {
      print('last one == ${widget.assetPackPath}/sound1.mp3');
      player.setFilePath('${widget.assetPackPath}/sound1.mp3');
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
                child: Icon(Icons.play_arrow)),
          ),
        ],
      ),
    );
  }
}
