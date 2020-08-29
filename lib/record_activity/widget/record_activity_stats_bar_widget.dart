import 'package:flutter/material.dart';
import 'package:flutterapp/core/enums/app_config.dart';
import 'package:flutterapp/record_activity/model/record_activity_widget_model.dart';
import 'package:intl/intl.dart';

class RecordActivityStatsBarWidget extends StatefulWidget {
  final RecordActivityWidgetModel model;

  RecordActivityStatsBarWidget(this.model);

  _RecordActivityStatsBarWidgetState createState() => _RecordActivityStatsBarWidgetState();
}

class _RecordActivityStatsBarWidgetState extends State<RecordActivityStatsBarWidget> {

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      color: AppConfig.MATERIAL_PALETTE.shade300,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    new NumberFormat("##0.0", "en_US").format(widget.model.currentDistance).toString() +
                        '/' +
                        new NumberFormat("##0.0", "en_US").format(widget.model.overallDistance).toString() +
                        ' km',
                    style: TextStyle(fontSize: 30)),
              ],
            ),
          ),
          Expanded(
            flex: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('${widget.model.currentPlayerPosition}/${widget.model.ranking.length}', style: TextStyle(fontSize: 30)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
