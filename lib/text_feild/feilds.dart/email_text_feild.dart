import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:quform/text_feild/util/validators.dart';

/// A specialized text field for email input with built-in email validation.
///
/// This widget extends the base text field functionality with email-specific
/// features such as email keyboard type and validation. It automatically
/// validates that the input matches a standard email format.
class EmailTextFeild extends StatefulWidget {
  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// The text that describes the email input field.
  final String label;

  /// An optional function that validates the email input.
  ///
  /// If provided, this overrides the default email validation.
  /// Returns an error string if the email is invalid, or null if valid.
  final String? Function(String?)? validator;

  /// Whether this field is required to be filled out.
  ///
  /// When true, a red asterisk is shown next to the label and
  /// the field cannot be submitted empty.
  /// Defaults to false.
  final bool isRequired;

  /// Creates a new [EmailTextFeild].
  ///
  /// The [label] parameter is required and describes the field's purpose.
  ///
  /// The [controller] can be used to control the text being edited. If not provided,
  /// the widget will create its own [TextEditingController].
  ///
  /// The [isRequired] parameter determines if the field must be filled out.
  const EmailTextFeild({
    super.key,
    this.controller,
    required this.label,
    this.validator,
    this.isRequired = false,
  });

  @override
  State<EmailTextFeild> createState() => _EmailTextFeildState();
}

class _EmailTextFeildState extends State<EmailTextFeild> {
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
          validator: widget.validator ?? defaultValidator.emailValidator,
          keyboardType: TextInputType.emailAddress,
          enableSuggestions: true,
          decoration: InputDecoration(
            hintText: "e.g. example@domain.com",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
            fillColor: Colors.grey[200],
            filled: true,
          ),
        ),
      ],
    );
  }
}