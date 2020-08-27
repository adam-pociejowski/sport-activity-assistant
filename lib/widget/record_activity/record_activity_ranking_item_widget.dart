import 'package:flutter/material.dart';
import 'package:flutterapp/enums/ranking_item_race_event_type.dart';
import 'package:flutterapp/model/activity/record_activity_widget_model.dart';

class RecordActivityRankingItemWidget extends StatefulWidget {
  final RecordActivityWidgetRankingItem item;
  final MaterialColor materialColor;
  final int position;

  RecordActivityRankingItemWidget(this.item, this.materialColor, this.position);

  _RecordActivityRankingItemWidgetState createState() => _RecordActivityRankingItemWidgetState();
}

class _RecordActivityRankingItemWidgetState extends State<RecordActivityRankingItemWidget> {

  Widget build(BuildContext context) {
    return Card(
      color: _decideWhichItemColor(widget.item.itemType),
      child: Container(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: <Widget>[
            _prepareColumn('${widget.position}.', 12, CrossAxisAlignment.start),
            _prepareFlagImage(widget.item.country, 8, CrossAxisAlignment.start),
            _prepareColumn(widget.item.name, 47, CrossAxisAlignment.start),
            _prepareColumn(widget.item.timeText, 26, CrossAxisAlignment.end),
            _prepareConditionIcon(double.parse(widget.item.power), 7)
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

  Expanded _prepareConditionIcon(double condition, int flex) {
    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _prepareConditionIconContainer(condition)
        ],
      ),
    );
  }

  Container _prepareConditionIconContainer(double condition) {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, right: 0.0, bottom: 4.0, top: 4.0),
      height: 26,
      child: Image(
        image: AssetImage("assets/images/icons/${_chooseIconByRiderCondition(condition)}.png"),
      ),
    );
  }

  String _chooseIconByRiderCondition(double condition) {
    if (condition > 0.96) {
      return "flame";
    } else if (condition > 0.92) {
      return "up";
    } else if (condition > 0.8) {
      return "equal_black";
    } else if (condition > 0.75) {
      return "down";
    }
    return "crisis";
  }

  Expanded _prepareFlagImage(String country, int flex, CrossAxisAlignment align) {
    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: align,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 0.0, right: 4.0),
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
