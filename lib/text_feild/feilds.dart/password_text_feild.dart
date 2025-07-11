import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quform/text_feild/util/validators.dart';

/// A specialized text field for password input with built-in password validation
/// and visibility toggle functionality.
///
/// This widget provides a secure way to enter passwords with the following features:
/// - Password visibility toggle (enabled by default)
/// - Default password validation rules
/// - Required field validation
/// - Custom validation support
class PasswordTextFeild extends StatefulWidget {
  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// The text that describes the password input field.
  final String label;

  /// An optional function that validates the password input.
  ///
  /// If provided, this overrides the default password validation.
  /// Returns an error string if the password is invalid, or null if valid.
  final String? Function(String?)? validator;

  /// Whether this field is required to be filled out.
  ///
  /// When true, a red asterisk is shown next to the label and
  /// the field cannot be submitted empty.
  /// Defaults to false.
  final bool isRequired;

  /// Whether to show the visibility toggle button.
  ///
  /// When true (default), an eye icon is shown that toggles password visibility.
  /// When false, the password is always obscured and the toggle is hidden.
  final bool showVisibilityToggle;

  /// Creates a new [PasswordTextFeild].
  ///
  /// The [label] parameter is required and describes the field's purpose.
  ///
  /// The [controller] can be used to control the text being edited. If not provided,
  /// the widget will create its own [TextEditingController].
  ///
  /// The [isRequired] parameter determines if the field must be filled out.
  ///
  /// The [showVisibilityToggle] controls whether to show the password visibility toggle.
  const PasswordTextFeild({
    super.key,
    this.controller,
    required this.label,
    this.validator,
    this.isRequired = false,
    this.showVisibilityToggle = true,
  });

  @override
  State<PasswordTextFeild> createState() => _PasswordTextFeildState();
}

class _PasswordTextFeildState extends State<PasswordTextFeild> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultValidator = Validators();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(widget.label),
            if (widget.isRequired) 
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text("*", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
        SizedBox(height: 10),
        TextFormField(
          key: widget.key,
          controller: widget.controller,
          validator: widget.validator ?? defaultValidator.passwordValidator,
          obscureText: _obscureText,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: "Enter your password",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
            fillColor: Colors.grey[200],
            filled: true,
            suffixIcon: widget.showVisibilityToggle
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: _toggleVisibility,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}