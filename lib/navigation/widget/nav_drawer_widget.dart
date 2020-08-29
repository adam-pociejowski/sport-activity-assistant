import 'package:flutter/material.dart';
import 'package:flutterapp/record_activity/observer/compare_your_results_location_observer.dart';
import 'package:flutterapp/dashboard/widget/dashboard_widget.dart';
import 'package:flutterapp/race/widget/race_list_widget.dart';
import 'package:flutterapp/record_activity/widget/record_activity_widget.dart';

class NavDrawerWidget extends StatelessWidget {
  final MaterialColor materialPalette;

  NavDrawerWidget(this.materialPalette);

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
                MaterialPageRoute(builder: (context) => DashboardWidget(materialPalette)),
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Record activity'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecordActivityWidget(new CompareYourResultsLocationObserver(), materialPalette)),
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Virtual ride'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RaceListWidget(materialPalette)),
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