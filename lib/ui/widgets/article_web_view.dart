import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebView extends StatelessWidget {
  final String url;
  const ArticleWebView({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()..loadRequest(Uri.parse(url));
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
