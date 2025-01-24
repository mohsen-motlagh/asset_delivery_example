import 'package:asset_delivery_example/download_assets_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asset Delivery Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return DownloadAssetsPage(
                        assetPackName: 'music',
                        assetsCount: 4,
                        namingPattern: 'sound%d',
                        fileExtension: 'mp3',
                      );
                    },
                  ),
                );
              },
              child: Text('Play sounds'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return DownloadAssetsPage(
                        assetPackName: 'video',
                        assetsCount: 1,
                        namingPattern: 'video%d',
                        fileExtension: 'mp4',
                      );
                    },
                  ),
                );
              },
              child: Text('Play videos'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (context.mounted) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return DownloadAssetsPage(
                          assetPackName: 'dogImage',
                          assetsCount: 3,
                          namingPattern: 'dog%d',
                          fileExtension: 'jpg',
                        );
                      },
                    ),
                  );
                }
              },
              child: Text('Show Dog Images'),
            ),
          ],
        ),
      ),
    );
  }
}
