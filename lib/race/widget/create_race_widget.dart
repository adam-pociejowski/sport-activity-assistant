import 'package:flutter/material.dart';
import 'package:flutterapp/core/enums/activity_type.dart';
import 'package:flutterapp/core/model/custom_form_field.dart';
import 'package:flutterapp/navigation/widget/nav_drawer_widget.dart';
import 'package:flutterapp/race/builder/race_init_builder.dart';
import 'package:flutterapp/race/widget/create_race_stage_widget.dart';
import 'abstract_create_race_widget.dart';

class CreateRaceWidget extends StatefulWidget {

  CreateRaceWidget();

  _CreateRaceWidgetState createState() => _CreateRaceWidgetState();
}

class _CreateRaceWidgetState extends AbstractCreateStageWidgetState<CreateRaceWidget> {
  final raceInitBuilder = new RaceInitBuilder();
  static final nameField = new CustomFormField('NAME', 'String', 'Race name', 'Race');
  static final difficultyField = new CustomFormField('DIFFICULTY', 'number', 'Difficulty level (0-1)', '0.5');
  static final ridersAmountField = new CustomFormField('RIDERS_AMOUNT', 'number', 'Riders amount', '200');
  static final ridersRaceConditionFVariabilityField = new CustomFormField('RIDERS_RACE_CONDITION_VARIABILITY', 'number', 'Race condition variability', '0.05');
  static final ridersCurrentConditionFVariabilityField = new CustomFormField('RIDERS_CURRENT_CONDITION_VARIABILITY', 'number', 'Current condition variability', '0.15');
  static final ridersConditionChangePerEventField = new CustomFormField('RIDERS_CONDITION_CHANGE_PER_EVENT', 'number', 'Max condition change per event', '0.02');
  static final randomFactorField = new CustomFormField('RANDOM_FACTOR', 'number', 'Random factor', '0.02');
  static final resultsScatteringField = new CustomFormField('RESULTS_SCATTERING', 'number', 'Results scattering', '0.8');

  _CreateRaceWidgetState() : super([
    nameField,
    difficultyField,
    ridersAmountField,
    ridersRaceConditionFVariabilityField,
    ridersCurrentConditionFVariabilityField,
    ridersConditionChangePerEventField,
    randomFactorField,
    resultsScatteringField,
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
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            CreateRaceStageWidget(
                raceInitBuilder
                      .name(textControllers[nameField].text)
                      .difficulty(double.parse(textControllers[difficultyField].text))
                      .ridersAmount(int.parse(textControllers[ridersAmountField].text))
                      .activityType(ActivityType.OUTDOOR_RIDE.toString())
                      .riderRaceConditionVariability(double.parse(textControllers[ridersRaceConditionFVariabilityField].text))
                      .riderCurrentConditionVariability(double.parse(textControllers[ridersCurrentConditionFVariabilityField].text))
                      .maxRiderCurrentConditionChangePerEvent(double.parse(textControllers[ridersConditionChangePerEventField].text))
                      .randomFactorVariability(double.parse(textControllers[randomFactorField].text))
                      .resultsScattering(double.parse(textControllers[resultsScatteringField].text))))
    );
  }
}