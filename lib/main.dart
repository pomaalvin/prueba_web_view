import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prueba_web_view/web_izi.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prueba Izi Lite WebView',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff5558F9),
          child: const Icon(Icons.mobile_friendly),
          onPressed: () {
            _showPage(context);
          }),
      body: const Center(
        child: Text("WEB VIEW TEST"),
      ),
    );
  }

  _showPage(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const WebIzi()));
  }
}
