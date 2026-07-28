import 'package:bh_finder/core/authentication/repositories/auth_repository.dart';

import 'package:bh_finder/roles/tenant/features/auth/validators/field_validation.dart';

import 'package:bh_finder/roles/tenant/features/auth/validators/name_validator.dart';
import 'package:bh_finder/roles/tenant/features/auth/validators/email_validator.dart';
import 'package:bh_finder/roles/tenant/features/auth/validators/phone_validator.dart';
import 'package:bh_finder/roles/tenant/features/auth/validators/password_validator.dart';
import 'package:bh_finder/roles/tenant/features/auth/validators/confirm_password_validator.dart';
import 'package:bh_finder/roles/tenant/features/auth/validators/gender_validator.dart';

class AuthViewModel {
  //============================================================================
  //! REPOSITORY
  //============================================================================

  final AuthRepository _repository;

  AuthViewModel({required AuthRepository repository})
    : _repository = repository;

  //============================================================================
  //! VALIDATION STATES
  //============================================================================

  FieldValidation firstNameValidation = const FieldValidation();

  FieldValidation lastNameValidation = const FieldValidation();

  FieldValidation emailValidation = const FieldValidation();

  FieldValidation phoneValidation = const FieldValidation();

  FieldValidation genderValidation = const FieldValidation();

  FieldValidation passwordValidation = const FieldValidation();

  FieldValidation confirmPasswordValidation = const FieldValidation();

  String? loginError;

  //============================================================================
  //! VALIDATION
  //============================================================================

  void validateFirstName(String value) {
    firstNameValidation = NameValidator.validate(
      value,
      fieldName: 'First name',
    );
  }

  void validateLastName(String value) {
    lastNameValidation = NameValidator.validate(value, fieldName: 'Last name');
  }

  void validateEmail(String value) {
    emailValidation = EmailValidator.validate(value);
  }

  void validatePhone(String value) {
    phoneValidation = PhoneValidator.validate(value);
  }

  void validateGender(String? value) {
    genderValidation = GenderValidator.validate(value);
  }

  void validatePassword(String value) {
    passwordValidation = PasswordValidator.validate(value);
  }

  void validateConfirmPassword({
    required String password,
    required String confirmPassword,
  }) {
    confirmPasswordValidation = ConfirmPasswordValidator.validate(
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  void setLoginError(String message) {
    loginError = message;
  }

  void clearLoginError() {
    loginError = null;
  }

  //============================================================================
  //! AUTHENTICATION
  //============================================================================

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String gender,
    required String password,
  }) async {
    await _repository.signUp(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      gender: gender,
      password: password,
    );
  }

  Future<void> signIn({required String email, required String password}) async {
    await _repository.signIn(email: email, password: password);
  }

  Future<void> signOut() async {
    await _repository.signOut();
  }

  Future<void> updatePassword({required String password}) async {
    await _repository.updatePassword(password: password);
  }

  Future<void> resendEmailVerification({required String email}) async {
    await _repository.resendEmailVerification(email: email);
  }

  Future<bool> isEmailVerified() async {
    return await _repository.isEmailVerified();
  }

  //============================================================================
  //! AUTH ERROR MESSAGES
  //============================================================================

  String getFriendlyAuthError(Object error) {
    final message = error.toString().toLowerCase();

    if (message.contains('user already registered')) {
      return 'An account with this email already exists.';
    }

    if (message.contains('email not confirmed')) {
      return 'Please verify your email before logging in.';
    }

    if (message.contains('invalid login credentials')) {
      return 'Invalid email or password.';
    }

    if (message.contains('over_email_send_rate_limit')) {
      return 'You have requested verification emails too frequently.\n\nPlease wait a few minutes before trying again.';
    }

    if (message.contains('signup_disabled')) {
      return 'Account registration is currently unavailable.';
    }

    if (message.contains('network') ||
        message.contains('socketexception') ||
        message.contains('failed host lookup')) {
      return 'No internet connection.';
    }

    return 'Unable to log in. Please try again.';
  }

  //============================================================================
  //! RESET PASSWORD
  //============================================================================

  Future<void> resetPassword({required String email}) async {
    await _repository.resetPassword(email: email);
  }

  //============================================================================
  //! FORM VALIDITY
  //============================================================================

  bool get canCreateAccount {
    return firstNameValidation.isValid &&
        lastNameValidation.isValid &&
        emailValidation.isValid &&
        phoneValidation.isValid &&
        genderValidation.isValid &&
        passwordValidation.isValid &&
        confirmPasswordValidation.isValid;
  }

  bool get canLogin {
    return emailValidation.isValid && passwordValidation.isValid;
  }

  //============================================================================
  //! RESET
  //============================================================================

  void resetValidation() {
    firstNameValidation = const FieldValidation();

    lastNameValidation = const FieldValidation();

    emailValidation = const FieldValidation();

    phoneValidation = const FieldValidation();

    genderValidation = const FieldValidation();

    passwordValidation = const FieldValidation();

    confirmPasswordValidation = const FieldValidation();

    loginError = null;
  }
}
