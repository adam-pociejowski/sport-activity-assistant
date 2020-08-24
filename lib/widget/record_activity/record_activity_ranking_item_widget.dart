import 'package:flutter/material.dart';
import 'package:flutterapp/enums/ranking_item_race_event_type.dart';
import 'package:flutterapp/model/activity/record_activity_widget_model.dart';

class RecordActivityRankingItemWidget extends StatefulWidget {
  RecordActivityWidgetRankingItem item;
  MaterialColor materialColor;
  int position;

  RecordActivityRankingItemWidget(this.item, this.materialColor, this.position);

  @override
  _RecordActivityRankingItemWidgetState createState() => _RecordActivityRankingItemWidgetState();
}

class _RecordActivityRankingItemWidgetState extends State<RecordActivityRankingItemWidget> {

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _decideWhichItemColor(widget.item.itemType),
      child: Container(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: <Widget>[
            _prepareColumn('${widget.position}.', 10, CrossAxisAlignment.start),
            _prepareFlagImage(widget.item.country, 8, CrossAxisAlignment.start),
            _prepareColumn(widget.item.name, 46, CrossAxisAlignment.start),
            _prepareColumn(widget.item.power.toString(), 12, CrossAxisAlignment.start),
            _prepareColumn(widget.item.timeText, 24, CrossAxisAlignment.end)
          ],
        ),
      ),
    );
  }

  Color _decideWhichItemColor(RankingItemRaceEventType type) {
    switch (type) {
      case RankingItemRaceEventType.USER_ACTIVITY:
        return widget.materialColor.shade300;
      case RankingItemRaceEventType.USER_OLD_ACTIVITY:
        return widget.materialColor.shade200;
      default:
        return widget.materialColor.shade100;
    }
  }

  Expanded _prepareFlagImage(String country, int flex, CrossAxisAlignment align) {
    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: align,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 2.0, right: 6.0),
            child: Image(
              image: AssetImage("assets/images/flags_light/$country.png"),
            ),
          ),
        ],
      ),
    );
  }

  Expanded _prepareColumn(String text, int flex, CrossAxisAlignment align) {
    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: align,
        children: <Widget>[
          Text(text, style: TextStyle(fontSize: 22)),
        ],
      ),
    );
  }
}
