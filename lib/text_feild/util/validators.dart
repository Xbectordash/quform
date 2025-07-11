class Validators {
  /// Validates that the text is not empty and has at least 3 characters.
  String? textValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return 'This field is required';
    }
    if (text.trim().length < 3) {
      return 'Must be at least 3 characters';
    }
    return null;
  }

  /// Validates email format.
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

  /// Validates phone number (10 digits only).
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

  /// Validates password (minimum 6 characters).
  String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /// Validates that the input contains only digits (no alphabets or symbols).
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

  /// Validates document field (must not be empty, min 5 characters).
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
