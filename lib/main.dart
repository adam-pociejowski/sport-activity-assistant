import 'package:flutter/material.dart';
import 'package:flutterapp/record_activity//record_activity_widget.dart';
import 'package:global_configuration/global_configuration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("application_configuration");
  runApp(MyApp());
}

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
