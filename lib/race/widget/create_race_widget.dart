import 'package:flutter/material.dart';
import 'package:flutterapp/navigation/widget/nav_drawer_widget.dart';
import 'package:global_configuration/global_configuration.dart';

class CreateRaceWidget extends StatefulWidget {
  final MaterialColor materialPalette;

  CreateRaceWidget(this.materialPalette);

  _CreateRaceWidgetState createState() => _CreateRaceWidgetState();
}

class _CreateRaceWidgetState extends State<CreateRaceWidget> {
  final apiUrl = GlobalConfiguration().getString("sport_activity_api_url");
  final _formKey = GlobalKey<FormState>();
  final Map<_FormField, TextEditingController> textControllers = {};

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawerWidget(widget.materialPalette),
      appBar: AppBar(
        title: Text('Create new race'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _prepareTextField(_FormField.NAME),
                _prepareTextField(_FormField.DIFFICULTY),
                _prepareTextField(_FormField.RIDERS_AMOUNT),
                _prepareTextField(_FormField.RIDERS_RACE_CONDITION_VARIABILITY),
                _prepareTextField(_FormField.RIDERS_CURRENT_CONDITION_VARIABILITY),
                _prepareTextField(_FormField.RIDERS_CONDITION_CHANGE_PER_EVENT),
                _prepareTextField(_FormField.RANDOM_FACTOR),
                _prepareTextField(_FormField.RESULTS_SCATTERING),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        print(_formKey.currentState.toString());
                      }
                    },
                    child: Text('Confirm'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _prepareTextField(_FormField field) {
    return TextFormField(
      keyboardType: field.type == 'String' ? TextInputType.text : TextInputType.number,
      controller: textControllers.putIfAbsent(field, () => TextEditingController(text: field.defaultValue)),
      decoration: InputDecoration(
        labelText: field.label,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }
}

class _FormField {
  static const _FormField NAME = _FormField._('NAME', 'String', 'Race name', 'Race');
  static const _FormField DIFFICULTY = _FormField._('DIFFICULTY', 'number', 'Difficulty level (0-1)', '0.5');
  static const _FormField RIDERS_AMOUNT = _FormField._('RIDERS_AMOUNT', 'number', 'Riders amount', '200');
  static const _FormField RIDERS_RACE_CONDITION_VARIABILITY = _FormField._('RIDERS_RACE_CONDITION_VARIABILITY', 'number', 'Race condition variability', '0.05');
  static const _FormField RIDERS_CURRENT_CONDITION_VARIABILITY = _FormField._('RIDERS_CURRENT_CONDITION_VARIABILITY', 'number', 'Current condition variability', '0.15');
  static const _FormField RIDERS_CONDITION_CHANGE_PER_EVENT = _FormField._('RIDERS_CONDITION_CHANGE_PER_EVENT', 'number', 'Max condition change per event', '0.02');
  static const _FormField RANDOM_FACTOR = _FormField._('RANDOM_FACTOR', 'number', 'Random factor', '0.02');
  static const _FormField RESULTS_SCATTERING = _FormField._('RESULTS_SCATTERING', 'number', 'Results scattering', '0.8');

  final String _name;
  final String label;
  final String type;
  final String defaultValue;

  const _FormField._(this._name, this.type, this.label, this.defaultValue);

  String toString() {
    return _name;
  }
}
