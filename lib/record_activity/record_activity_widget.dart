import 'package:flutter/material.dart';
import 'package:flutterapp/location/location_observer.dart';
import 'package:flutterapp/location/location_service.dart';
import 'package:location/location.dart';

class RecordActivityWidget extends StatefulWidget {
  @override
  _RecordActivityWidgetState createState() => _RecordActivityWidgetState();
}

class _RecordActivityWidgetState extends State<RecordActivityWidget> implements LocationObserver {
  var locationService = new LocationService();
  String _locationField = 'Searching for location';

  @override
  Widget build(BuildContext context) {
    locationService.registerObserver(this);
    return Scaffold(
      appBar: AppBar(
        title: Text('Record activity'),
      ),
      body: Center(
        child: Text(_locationField),
      ),
    );
  }

  @override
  void onLocationChanged(LocationData locationData) {
    print('Location [ lat: ${locationData.latitude}, lng: ${locationData.longitude} ]');
    setState(() {
      _locationField = 'Location [ lat: ${locationData.latitude}, lng: ${locationData.longitude} ]';
    });
  }
}
