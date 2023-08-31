export 'validators.dart';

bool isValueNotEmpty(String? value) {
  return (value == null || value.isEmpty || value.trim().length <= 1);
}

bool isValueNotEmptyAndPositiveNumber(String? value) {
  return (value == null ||
      value.isEmpty ||
      int.tryParse(value) == null ||
      int.tryParse(value)! <= 0);
}
