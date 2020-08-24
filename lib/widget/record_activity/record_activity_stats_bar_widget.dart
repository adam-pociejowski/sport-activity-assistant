import 'package:flutter/material.dart';
import 'package:flutterapp/model/activity/record_activity_widget_model.dart';
import 'package:intl/intl.dart';

class RecordActivityStatsBarWidget extends StatefulWidget {
  RecordActivityWidgetModel model;
  MaterialColor materialColor;

  RecordActivityStatsBarWidget(this.model, this.materialColor);

  @override
  _RecordActivityStatsBarWidgetState createState() => _RecordActivityStatsBarWidgetState();
}

class _RecordActivityStatsBarWidgetState extends State<RecordActivityStatsBarWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      color: widget.materialColor.shade300,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    new NumberFormat("##0.00", "en_US").format(widget.model.currentDistance).toString() +
                        '/' +
                        new NumberFormat("##0.00", "en_US").format(widget.model.overallDistance).toString() +
                        ' km',
                    style: TextStyle(fontSize: 35)),
              ],
            ),
          ),
          Expanded(
            flex: 35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('${widget.model.currentPlayerPosition}/${widget.model.ranking.length}', style: TextStyle(fontSize: 35)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
