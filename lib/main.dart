import 'package:flutter/material.dart';
import 'package:flutterapp/race/widget/create_race_widget.dart';
import 'package:global_configuration/global_configuration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("application_configuration");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sport Activity Assistant',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
//      home: RecordActivityWidget(new SimulateRaceLocationObserver(null)),
//      home: RaceListWidget(),
//      home: DashboardWidget(),
      home: CreateRaceWidget(),
    );
  }
}
