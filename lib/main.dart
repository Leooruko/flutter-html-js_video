import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyVideoPage(),
    );
  }
}

class MyVideoPage extends StatefulWidget {
  const MyVideoPage({super.key});

  @override
  State<MyVideoPage> createState() => _MyVideoPageState();
}

class _MyVideoPageState extends State<MyVideoPage> {
  WebViewController? _webViewController;

  @override
  void initState() {
    _webViewController = WebViewController()
      ..loadFlutterAsset("assets/webview/index.html")
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'messageHandler',
        onMessageReceived: (JavaScriptMessage javaScriptMessage) {
          print("message from the web view=\"${javaScriptMessage.message}\"");
        },
      );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // _webViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video App"),
      ),
      body: buildWebView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.send),
        onPressed: () {
          _webViewController!.runJavaScript(
              'receiveMessegeFromFlutter("Hello  Flutter");');
        },
      ),
    );
  }

  Widget buildWebView() {
    return WebViewWidget(
      controller: _webViewController!,
    );
  }
}
