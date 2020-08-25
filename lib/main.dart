import 'package:flutter/material.dart';
import 'package:flutterapp/service/simulate_race_location_observer.dart';
import 'package:flutterapp/widget/dashboard/dashboard_widget.dart';
import 'package:flutterapp/widget/record_activity/record_activity_widget.dart';
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
//      home: ChooseActivityTypeWidget(Colors.lime),
      home: DashboardWidget(Colors.lime),
    );
  }
}
