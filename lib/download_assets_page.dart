import 'dart:async';
import 'dart:io';

import 'package:asset_delivery/asset_delivery.dart';
import 'package:asset_delivery/asset_delivery_method_channel.dart';
import 'package:asset_delivery_example/play_sounds_page.dart';
import 'package:asset_delivery_example/play_video_page.dart';
import 'package:asset_delivery_example/show_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DownloadAssetsPage extends StatefulWidget {
  final String assetPackName;
  final String namingPattern;
  final int assetsCount;
  final String fileExtension;
  const DownloadAssetsPage({
    super.key,
    required this.assetPackName,
    required this.namingPattern,
    required this.assetsCount,
    required this.fileExtension,
  });

  @override
  State<DownloadAssetsPage> createState() => _DownloadAssetsPageState();
}

class _DownloadAssetsPageState extends State<DownloadAssetsPage> with TickerProviderStateMixin {
  final _assetStatusController = StreamController<StatusMap>.broadcast();
  final _assetIosStatusController = StreamController<double>.broadcast();
  double? downloadProgress;
  late AnimationController _downloadAnimation;

  @override
  void initState() {
    if (Platform.isAndroid) {
      try {
        _setAssetsStatusListener();
      } catch (e) {
        debugPrint('error message for status checking $e');
      }
      AssetDelivery.fetch(widget.assetPackName);
      _assetStatusController.stream.listen((event) {
        if (event.status == 'COMPLETED') {
          AssetDelivery.getAssetPackPath(
            assetPackName: widget.assetPackName,
            count: widget.assetsCount,
            namingPattern: widget.namingPattern,
            fileExtension: widget.fileExtension,
          ).then(
            (path) {
              if (path != null && mounted) {}
            },
          );
        }
      });
    } else {
      getDownloadResourcesPath().catchError((e) {
        if (mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('there is an error because of network connection ==== ${e.toString()}'),
            ),
          );
        }

        return e;
      });
      _assetIosStatusController.stream.listen(
        (event) {
          if (event == 1.0 && mounted) {
            print('completed');
          }
        },
      );
    }
    _downloadAnimation = AnimationController(vsync: this, value: 0.0, upperBound: 0.99);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getDownloadResourcesPath(),
      builder: (context, path) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Download Sound Assets'),
          ),
          body: StreamBuilder<StatusMap>(
            stream: _assetStatusController.stream,
            builder: (context, snapshot) {
              print(snapshot.data?.downloadProgress);
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: LinearProgressIndicator(
                        value: snapshot.data?.downloadProgress,
                      ),
                    ),
                    Text('${snapshot.data?.status}...'),
                    if (path.data != null)
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                if (widget.fileExtension == 'mp3') {
                                  return PlaySoundsPage(assetPackPath: path.data!);
                                } else if (widget.fileExtension == 'jpg') {
                                  return ShowImages(assetPackPath: path.data!);
                                } else {
                                  return PlayVideoPage(assetPackPath: path.data!);
                                }
                              },
                            ),
                          );
                        },
                        child: Text('Play Sounds'),
                      )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _assetStatusController.close();
    _assetIosStatusController.close();
    _downloadAnimation.dispose();
    super.dispose();
  }

  void _setAssetsStatusListener() {
    AssetDelivery.getAssetPackStatus((statusMap) {
      StatusMap status = StatusMap.fromJson(statusMap);
      _assetStatusController.add(status);
    });
  }

  Future<String> getDownloadResourcesPath() async {
    AssetDelivery.getAssetPackStatus((onUpdate) {
      _downloadAnimation.value = onUpdate['downloadProgress'];
      _assetIosStatusController.add(onUpdate['downloadProgress']);
    });

    try {
      final path = await AssetDelivery.getAssetPackPath(
        assetPackName: widget.assetPackName,
        count: widget.assetsCount,
        namingPattern: widget.namingPattern,
        fileExtension: widget.fileExtension,
      ) as String;
      return path;
    } on PlatformException catch (e) {
      throw (e.message ?? 'Error');
    }
  }
}
