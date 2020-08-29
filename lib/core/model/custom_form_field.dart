class CustomFormField {
  final String _name;
  final String label;
  final String type;
  final String defaultValue;

  CustomFormField(this._name, this.type, this.label, this.defaultValue);

  String toString() {
    return _name;
  }
}