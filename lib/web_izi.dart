import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class WebIzi extends StatefulWidget {
  const WebIzi({Key? key}) : super(key: key);
  @override
  State<WebIzi> createState() => _WebIziState();
}

class _WebIziState extends State<WebIzi> {
  String? token;
  String? userId;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  void initState() {
    _getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPop(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff5558F9),
            actions: [
              IconButton(
                  onPressed: () async {
                    WebViewController webViewController =
                        await _controller.future;
                    webViewController.reload();
                  },
                  icon: const Icon(Icons.refresh))
            ],
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close)),
            automaticallyImplyLeading: false,
          ),
          body: token != null && userId != null
              ? WebView(
                  initialUrl: 'http://urlIziLite?userId=$userId&token=$token',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController controller) {
                    _controller.complete(controller);
                  },
                )
              : const LoadingIndicator()),
    );
  }

  _willPop() async {
    WebViewController webViewController = await _controller.future;
    bool canNavigate = await webViewController.canGoBack();
    if (canNavigate) {
      webViewController.goBack();
    }
    return false;
  }

  _getToken() async {
    var response = await http.post(Uri.parse("https://urlLogin"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "correoElectronico": "correo",
          "contrasena": "contrasena",
          "cadena": "cadena"
        }));
    if (response.statusCode == 200 && mounted) {
      setState(() {
        userId = "12341234";
        token = jsonDecode(response.body)["token"];
      });
    }
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
    );
  }
}
