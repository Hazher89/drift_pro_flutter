import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YouTubePlayerWidget extends StatefulWidget {
  final String videoId;
  final String title;

  const YouTubePlayerWidget({
    Key? key,
    required this.videoId,
    required this.title,
  }) : super(key: key);

  @override
  State<YouTubePlayerWidget> createState() => _YouTubePlayerWidgetState();
}

class _YouTubePlayerWidgetState extends State<YouTubePlayerWidget> {
  late WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          'https://www.youtube.com/embed/${widget.videoId}?autoplay=1&controls=1&rel=0',
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            ),
        ],
      ),
    );
  }
}

class YouTubeTestApp extends StatelessWidget {
  const YouTubeTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube CarPlay Test',
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
      home: const YouTubeTestHome(),
    );
  }
}

class YouTubeTestHome extends StatelessWidget {
  const YouTubeTestHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final testVideos = [
      {
        'id': 'dQw4w9WgXcQ',
        'title': 'Test Video 1 - Rick Roll',
        'description': 'Classic test video for CarPlay testing',
      },
      {
        'id': 'jNQXAC9IVRw',
        'title': 'Test Video 2 - Me at the zoo',
        'description': 'First YouTube video ever uploaded',
      },
      {
        'id': 'kJQP7kiw5Fk',
        'title': 'Test Video 3 - Despacito',
        'description': 'Popular test video for CarPlay',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('YouTube CarPlay Test'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: testVideos.length,
        itemBuilder: (context, index) {
          final video = testVideos[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: Container(
                width: 80,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.play_circle_outline,
                  color: Colors.red,
                  size: 30,
                ),
              ),
              title: Text(
                video['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(video['description']!),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => YouTubePlayerWidget(
                      videoId: video['id']!,
                      title: video['title']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}