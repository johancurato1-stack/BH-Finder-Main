import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/roles/tenant/features/auth/validators/field_validation.dart';

class PasswordValidator {
  const PasswordValidator._();

  static FieldValidation validate(String value) {
    if (value.isEmpty) {
      return const FieldValidation(
        state: ValidationState.invalid,
        message: 'Password is required.',
      );
    }

    if (value.length < 8) {
      return const FieldValidation(
        state: ValidationState.invalid,
        message: 'Password must be at least 8 characters.',
      );
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return const FieldValidation(
        state: ValidationState.invalid,
        message: 'Password must contain at least one uppercase letter.',
      );
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return const FieldValidation(
        state: ValidationState.invalid,
        message: 'Password must contain at least one lowercase letter.',
      );
    }

    if (!RegExp(r'\d').hasMatch(value)) {
      return const FieldValidation(
        state: ValidationState.invalid,
        message: 'Password must contain at least one number.',
      );
    }

    return const FieldValidation(state: ValidationState.valid);
  }
}
