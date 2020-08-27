import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterapp/enums/race_status.dart';
import 'package:flutterapp/model/simulate/race_config.dart';
import 'package:flutterapp/service/simulate_race_location_observer.dart';
import 'package:flutterapp/util/http_utils.dart';
import 'package:flutterapp/widget/nav_drawer_widget.dart';
import 'package:flutterapp/widget/record_activity/record_activity_widget.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:imagebutton/imagebutton.dart';

class CreateRaceWidget extends StatefulWidget {
  final MaterialColor materialPalette;

  CreateRaceWidget(this.materialPalette);

  _CreateRaceWidgetState createState() => _CreateRaceWidgetState();
}

class _CreateRaceWidgetState extends State<CreateRaceWidget> {
  final apiUrl = GlobalConfiguration().getString("sport_activity_api_url");

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawerWidget(widget.materialPalette),
      appBar: AppBar(
        title: Text('Choose activity type'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}
