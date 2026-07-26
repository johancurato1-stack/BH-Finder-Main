import 'package:bh_finder/core/enums/validation_state.dart';
import 'package:bh_finder/roles/tenant/features/auth/validators/field_validation.dart';

class PhoneValidator {
  const PhoneValidator._();

  static FieldValidation validate(String value) {
    final phone = value.trim();

    if (phone.isEmpty) {
      return const FieldValidation(
        state: ValidationState.invalid,
        message: 'Phone number is required.',
      );
    }

    // Accepts:
    // 09XXXXXXXXX
    // +639XXXXXXXXX
    final regex = RegExp(r'^(09\d{9}|\+639\d{9})$');

    if (!regex.hasMatch(phone)) {
      return const FieldValidation(
        state: ValidationState.invalid,
        message: 'Please enter a valid Philippine phone number.',
      );
    }

    return const FieldValidation(state: ValidationState.valid);
  }
}
