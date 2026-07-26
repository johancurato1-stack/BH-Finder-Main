import 'package:bh_finder/roles/tenant/features/auth/validators/field_validation.dart';
import 'package:bh_finder/core/enums/validation_state.dart';

class NameValidator {
  const NameValidator._();

  static FieldValidation validate(String value, {String fieldName = 'Name'}) {
    final text = value.trim();

    if (text.isEmpty) {
      return FieldValidation(
        state: ValidationState.invalid,
        message: '$fieldName is required.',
      );
    }

    if (text.length < 2) {
      return FieldValidation(
        state: ValidationState.invalid,
        message: '$fieldName must be at least 2 characters.',
      );
    }

    final regex = RegExp(r"^[A-Za-zÀ-ÿ\s'-]+$");

    if (!regex.hasMatch(text)) {
      return FieldValidation(
        state: ValidationState.invalid,
        message:
            '$fieldName can only contain letters, spaces, hyphens, and apostrophes.',
      );
    }

    return const FieldValidation(state: ValidationState.valid);
  }
}
