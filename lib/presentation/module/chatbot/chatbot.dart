import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  late final WebViewController _controller;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..loadRequest(
          Uri.parse("https://tawk.to/chat/684fafb96b65fa190ea700a5/1itrkcreg"))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => isLoading = true);
          },
          onPageFinished: (url) {
            setState(() => isLoading = false);
          },
          onWebResourceError: (error) {
            setState(() => isLoading = false);
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
