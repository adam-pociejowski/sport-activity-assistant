import 'package:flutter/material.dart';
import 'package:flutterapp/core/enums/app_config.dart';
import 'package:flutterapp/core/enums/ranking_type.dart';

class RecordActivityRankingTypeBarWidget extends StatefulWidget {
  final Function rankingTypeCallback;
  final RankingType rankingType;

  RecordActivityRankingTypeBarWidget(this.rankingTypeCallback, this.rankingType);

  _RecordActivityRankingTypeBarWidgetState createState() => _RecordActivityRankingTypeBarWidgetState();
}

class _RecordActivityRankingTypeBarWidgetState extends State<RecordActivityRankingTypeBarWidget> {
  RankingType selectedRankingType;

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      color: AppConfig.MATERIAL_PALETTE.shade300,
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
                    color: _chooseButtonColor(RankingType.PLAYER_NPC, widget.rankingType),
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
                    color: _chooseButtonColor(RankingType.PLAYER_NPC_WITH_HISTORY, widget.rankingType),
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
                    color: _chooseButtonColor(RankingType.PLAYER_NPC_GENERAL, widget.rankingType),
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

  Color _chooseButtonColor(RankingType buttonRankingType, RankingType selectedRankingType) {
    return buttonRankingType == selectedRankingType ?
            AppConfig.MATERIAL_PALETTE.shade400 :
            AppConfig.MATERIAL_PALETTE.shade50;
  }
}
