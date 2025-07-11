/// A collection of common form field validators.
///
/// This class provides static methods for validating different types of form input,
/// such as text, email, phone numbers, passwords, and document numbers.
///
/// Example usage:
/// ```dart
/// final validators = Validators();
/// final emailError = validators.emailValidator('test@example');
/// ```
class Validators {
  /// Validates that the text is not empty and has at least 3 characters.
  ///
  /// Returns:
  /// - `null` if the text is valid
  /// - An error message if the text is invalid
  ///
  /// Example:
  /// ```dart
  /// final error = validators.textValidator('ab'); // Returns 'Must be at least 3 characters'
  /// final valid = validators.textValidator('abc'); // Returns null
  /// ```
  String? textValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return 'This field is required';
    }
    if (text.trim().length < 3) {
      return 'Must be at least 3 characters';
    }
    return null;
  }

  /// Validates that the input is a properly formatted email address.
  ///
  /// The validation checks:
  /// 1. The field is not empty
  /// 2. The input matches a standard email pattern
  ///
  /// Returns:
  /// - `null` if the email is valid
  /// - An error message if the email is invalid
  ///
  /// Example:
  /// ```dart
  /// final error = validators.emailValidator('invalid-email');
  /// // Returns 'Invalid email address'
  /// ```
  String? emailValidator(String? email) {
    if (email == null || email.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!emailRegex.hasMatch(email.trim())) {
      return 'Invalid email address';
    }
    return null;
  }

  /// Validates that the input is a 10-digit phone number.
  ///
  /// The validation checks:
  /// 1. The field is not empty
  /// 2. The input contains exactly 10 digits
  ///
  /// Returns:
  /// - `null` if the phone number is valid
  /// - An error message if the phone number is invalid
  ///
  /// Example:
  /// ```dart
  /// final error = validators.phoneNumberValidator('12345');
  /// // Returns 'Phone number must be 10 digits'
  /// ```
  String? phoneNumberValidator(String? phone) {
    if (phone == null || phone.trim().isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^\d{10}$');
    if (!phoneRegex.hasMatch(phone.trim())) {
      return 'Phone number must be 10 digits';
    }
    return null;
  }

  /// Validates that the password meets minimum requirements.
  ///
  /// The validation checks:
  /// 1. The field is not empty
  /// 2. The password is at least 6 characters long
  ///
  /// Returns:
  /// - `null` if the password is valid
  /// - An error message if the password is too short
  ///
  /// Note: This is a basic validation. Consider adding more complex
  /// password requirements in production.
  ///
  /// Example:
  /// ```dart
  /// final error = validators.passwordValidator('12345');
  /// // Returns 'Password must be at least 6 characters'
  /// ```
  String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /// Validates that the input contains only numeric digits.
  ///
  /// The validation checks:
  /// 1. The field is not empty
  /// 2. The input contains only digits (0-9)
  /// 3. The input can be parsed as a number
  ///
  /// Returns:
  /// - `null` if the input is a valid number
  /// - An error message if the input is invalid
  ///
  /// Example:
  /// ```dart
  /// final error = validators.numberValidator('abc');
  /// // Returns 'Only digits are allowed'
  /// ```
  String? numberValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }

    final trimmed = value.trim();

    // Check: only digits allowed (0-9)
    final digitsOnlyRegex = RegExp(r'^\d+$');
    if (!digitsOnlyRegex.hasMatch(trimmed)) {
      return 'Only digits are allowed';
    }

    // Optional: You can still check if it's a valid number
    final number = num.tryParse(trimmed);
    if (number == null) {
      return 'Enter a valid number';
    }

    return null;
  }

  /// Validates a document field with basic requirements.
  ///
  /// The validation checks:
  /// 1. The field is not empty
  /// 2. The input is at least 5 characters long
  ///
  /// Returns:
  /// - `null` if the document is valid
  /// - An error message if the document is too short
  ///
  /// Example:
  /// ```dart
  /// final error = validators.documentFieldValidator('1234');
  /// // Returns 'Enter a valid document detail'
  /// ```
  String? documentFieldValidator(String? document) {
    if (document == null || document.trim().isEmpty) {
      return 'Document is required';
    }
    if (document.trim().length < 5) {
      return 'Enter a valid document detail';
    }
    return null;
  }
}
