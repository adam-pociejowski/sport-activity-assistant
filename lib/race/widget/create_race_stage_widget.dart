import 'package:flutter/material.dart';
import 'package:flutterapp/navigation/widget/nav_drawer_widget.dart';
import 'package:flutterapp/race/builder/race_init_builder.dart';
import 'package:flutterapp/core/model/custom_form_field.dart';
import 'abstract_create_race_widget.dart';

class CreateRaceStageWidget extends StatefulWidget {
  final RaceInitBuilder raceInitBuilder;

  CreateRaceStageWidget(this.raceInitBuilder);

  _CreateRaceStageWidgetState createState() => _CreateRaceStageWidgetState();
}

class _CreateRaceStageWidgetState extends AbstractCreateStageWidgetState<CreateRaceStageWidget> {
  static final distanceField = new CustomFormField('DISTANCE', 'number', 'Stage distance', '10000.00');
  static final flatFactorField = new CustomFormField('FLAT_FACTOR', 'number', 'Flat factor', '0.0');
  static final mountainFactorField = new CustomFormField('MOUNTAIN_FACTOR', 'number', 'Mountain factor', '1.0');
  static final hillFactorField = new CustomFormField('HILL_FACTOR', 'number', 'Hill factor', '0.0');
  static final timeTrialFactorField = new CustomFormField('TIME_TRIAL_FACTOR', 'number', 'Time trial factor', '0.0');

  _CreateRaceStageWidgetState() : super([
    distanceField,
    flatFactorField,
    mountainFactorField,
    hillFactorField,
    timeTrialFactorField
  ]);
  
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawerWidget(),
      appBar: AppBar(
        title: Text('Create new race'),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: appendSubmitButton(prepareTextFields())
            ),
          ),
        ),
      ),
    );
  }

  void doAfterValidatedFormSubmitted() {

  }
}