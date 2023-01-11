import 'package:amar_bongo_app/presentation/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late final WebViewController _controller;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    // #docregion platform_features

    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(url));
  }

  final String url = 'https://en.wikipedia.org/wiki/Bangladesh';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (await _controller.canGoBack()) {
            await _controller.goBack();
            return false;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Closed')),
            );
            return true;
          }
        },
        child: SafeArea(
          child: Scaffold(
            body: _isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.goldenColor,
                    ),
                  )
                : WebViewWidget(controller: _controller),
          ),
        ));
  }
}
