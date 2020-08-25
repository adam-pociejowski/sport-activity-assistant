import 'package:flutter/material.dart';
import 'package:flutterapp/service/compare_your_results_location_observer.dart';
import 'package:flutterapp/widget/dashboard/dashboard_widget.dart';
import 'package:flutterapp/widget/race_list/race_list_widget.dart';
import 'package:flutterapp/widget/record_activity/record_activity_widget.dart';

class NavDrawerWidget extends StatelessWidget {
  MaterialColor materialColor = Colors.lime;

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Sport Activity Assistant',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/side_menu_box.jpeg'))),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Dashboard'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DashboardWidget(materialColor)),
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Record activity'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecordActivityWidget(new CompareYourResultsLocationObserver())),
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Virtual ride'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RaceListWidget(materialColor)),
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {

            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}