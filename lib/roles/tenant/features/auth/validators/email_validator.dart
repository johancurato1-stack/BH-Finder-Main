import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/roles/tenant/features/auth/validators/field_validation.dart';

class EmailValidator {
  const EmailValidator._();

  static FieldValidation validate(String value) {
    final email = value.trim();

    if (email.isEmpty) {
      return const FieldValidation(
        state: ValidationState.invalid,
        message: 'Email is required.',
      );
    }

    final regex = RegExp(r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

    if (!regex.hasMatch(email)) {
      return const FieldValidation(
        state: ValidationState.invalid,
        message: 'Please enter a valid email address.',
      );
    }

    return const FieldValidation(state: ValidationState.valid);
  }
}
