import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_web/flutter_unity_widget_web.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter x Unity'),
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
  late UnityWebController _unityWebController;

  @override
  Widget build(BuildContext context) {
    return UnityWebWidget(
      url: 'http://localhost:${Uri.base.port}/unity/index.html',
      listenMessageFromUnity: _listenMessageFromUnity,
      onUnityLoaded: _onUnityLoaded,
    );
  }

  @override
  void dispose() {
    _unityWebController.dispose();
    super.dispose();
  }

  void _listenMessageFromUnity(String data) {
    if (data == 'load_next_scene') {
      // any message emitted from unty.
      _unityWebController.sendDataToUnity(
        gameObject: 'GameWindow',
        method: 'LoadNextScene',
        data: '0', // data sent to unity from flutter web.
      );
    }
  }

  void _onUnityLoaded(UnityWebController controller) {
    _unityWebController = controller;
    setState(() {});
  }
}
