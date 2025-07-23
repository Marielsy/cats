import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WikipediaWebView extends StatefulWidget {
  final String url;
  final String breedName;

  const WikipediaWebView({Key? key, required this.url, required this.breedName}) : super(key: key);

  @override
  State<WikipediaWebView> createState() => _WikipediaWebViewState();
}

class _WikipediaWebViewState extends State<WikipediaWebView> {
  bool _loading = true;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            setState(() {
              _loading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wikipedia: ${widget.breedName}')),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_loading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
