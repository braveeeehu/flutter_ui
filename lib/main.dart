import 'package:flutter/material.dart';
import 'package:flutter_ui/removebleflowitem/undivide_flow_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlowItem',
      home: UndivideFlowPage(),
    );
  }
}
