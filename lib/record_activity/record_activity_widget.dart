import 'package:flutter/material.dart';

class RecordActivityWidget extends StatefulWidget {
  @override
  _RecordActivityWidgetState createState() => _RecordActivityWidgetState();
}

class _RecordActivityWidgetState extends State<RecordActivityWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: Text('Test text'),
    );
  }
}
