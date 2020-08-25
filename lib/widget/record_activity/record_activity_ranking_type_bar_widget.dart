import 'package:flutter/material.dart';
import 'package:flutterapp/enums/ranking_type.dart';

class RecordActivityRankingTypeBarWidget extends StatefulWidget {
  MaterialColor materialPalette;
  Function rankingTypeCallback;

  RecordActivityRankingTypeBarWidget(this.rankingTypeCallback, this.materialPalette);

  _RecordActivityRankingTypeBarWidgetState createState() => _RecordActivityRankingTypeBarWidgetState();
}

class _RecordActivityRankingTypeBarWidgetState extends State<RecordActivityRankingTypeBarWidget> {

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      color: widget.materialPalette.shade300,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 33,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      widget.rankingTypeCallback(RankingType.PLAYER_NPC);
                    },
                    child: const Text('NORMAL', style: TextStyle(fontSize: 20)),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 33,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      widget.rankingTypeCallback(RankingType.PLAYER_NPC_WITH_HISTORY);
                    },
                    child: const Text('HISTORY', style: TextStyle(fontSize: 20)),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 33,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                      onPressed: () {
                        widget.rankingTypeCallback(RankingType.PLAYER_NPC_GENERAL);
                      },
                      child: const Text('GENERAL', style: TextStyle(fontSize: 20)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
