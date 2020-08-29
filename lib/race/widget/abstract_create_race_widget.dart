import 'package:flutter/material.dart';
import 'package:flutterapp/core/model/custom_form_field.dart';

abstract class AbstractCreateStageWidgetState<T extends StatefulWidget> extends State<T> {
  final Map<CustomFormField, TextEditingController> textControllers = {};
  final formKey = GlobalKey<FormState>();
  final List<CustomFormField> fields;

  AbstractCreateStageWidgetState(this.fields);

  void doAfterValidatedFormSubmitted();

  List<Widget> appendSubmitButton(List<Widget> children) {
    children.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          onPressed: () {
            if (formKey.currentState.validate()) {
              doAfterValidatedFormSubmitted();
            }
          },
          child: Text('Confirm'),
        )));
    return children;
  }

  List<Widget> prepareTextFields() {
    return fields
        .map<Widget>((field) => _prepareTextField(field))
        .toList();
  }

  Widget _prepareTextField(CustomFormField field) {
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