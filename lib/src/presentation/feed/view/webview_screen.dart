import 'package:flutter/material.dart';
import 'package:newsnews/src/core/theme/palette.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argument =
        ModalRoute.of(context)!.settings.arguments! as Map<String, String>;
    final title = argument["title"];
    final urlLink = argument["urlLink"];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primaryColor,
        title: Text(title!,
            style: const TextStyle(color: Palette.backgroundBoxColor)),
      ),
      body: WebView(
        initialUrl: urlLink,
      ),
    );
  }
}