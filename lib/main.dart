import 'package:flutter/material.dart';
import 'package:flutterapp/record_activity//record_activity_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sport Result Comparer',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: RecordActivityWidget(),
    );
  }
}
