import 'package:bh_finder/core/enums/enums.dart';

class FieldValidation {
  final ValidationState state;
  final String? message;

  const FieldValidation({this.state = ValidationState.neutral, this.message});

  bool get isValid => state == ValidationState.valid;

  bool get isInvalid => state == ValidationState.invalid;

  bool get isNeutral => state == ValidationState.neutral;
}
