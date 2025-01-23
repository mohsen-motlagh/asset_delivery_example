import 'package:asset_delivery_example/download_sound_assets_page.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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
              onPressed: () {},
              child: Text('Play sounds'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Play videos'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('show Cat Images'),
            ),
            ElevatedButton(
              onPressed: () async {
                final path = await getApplicationDocumentsDirectory();
                if (context.mounted) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return DownloadSoundAssetsPage();
                      },
                    ),
                  );
                }
              },
              child: Text('show Dog Images'),
            ),
          ],
        ),
      ),
    );
  }
}
