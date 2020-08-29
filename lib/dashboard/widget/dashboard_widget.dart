import 'package:flutter/material.dart';
import 'package:flutterapp/navigation/widget/nav_drawer_widget.dart';

class DashboardWidget extends StatefulWidget {

  DashboardWidget();

  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawerWidget(),
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
    );
  }
}
