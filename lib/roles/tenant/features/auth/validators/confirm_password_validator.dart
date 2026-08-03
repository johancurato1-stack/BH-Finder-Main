import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/roles/tenant/features/auth/validators/field_validation.dart';

class ConfirmPasswordValidator {
  const ConfirmPasswordValidator._();

  static FieldValidation validate({
    required String password,
    required String confirmPassword,
  }) {
    if (confirmPassword.isEmpty) {
      return const FieldValidation(
        state: ValidationState.invalid,
        message: 'Please confirm your password.',
      );
    }

    if (password != confirmPassword) {
      return const FieldValidation(
        state: ValidationState.invalid,
        message: 'Passwords do not match.',
      );
    }

    return const FieldValidation(state: ValidationState.valid);
  }
}
