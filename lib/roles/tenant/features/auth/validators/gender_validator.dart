import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/roles/tenant/features/auth/validators/field_validation.dart';

class GenderValidator {
  const GenderValidator._();

  static FieldValidation validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return const FieldValidation(
        state: ValidationState.invalid,
        message: 'Please select a gender.',
      );
    }

    return const FieldValidation(state: ValidationState.valid);
  }
}
