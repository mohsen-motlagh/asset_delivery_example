import 'dart:io';

import 'package:flutter/material.dart';

class ShowImages extends StatefulWidget {
  final String assetPackPath;
  const ShowImages({super.key, required this.assetPackPath});

  @override
  State<ShowImages> createState() => _ShowImagesState();
}

class _ShowImagesState extends State<ShowImages> {
  String? path;

  @override
  void initState() {
    if (Platform.isAndroid) {
      path = '${widget.assetPackPath}/dogImage';
    } else if (Platform.isIOS) {
      path = Uri.parse(widget.assetPackPath).toFilePath();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Images'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 20,
            children: [
              Image.file(File('$path/dog1.${imageExtention()}'), fit: BoxFit.fill),
              Image.file(File('$path/dog2.${imageExtention()}'), fit: BoxFit.fill),
              Image.file(File('$path/dog3.${imageExtention()}'), fit: BoxFit.fill),
            ],
          ),
        ),
      ),
    );
  }

  String imageExtention() {
    if (Platform.isIOS) {
      return 'png';
    } else {
      return 'jpg';
    }
  }
}
