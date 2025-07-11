import 'package:flutter/material.dart';
import 'package:quform/text_feild/util/validators.dart';

/// A customizable base text field widget that serves as the foundation for
/// specialized text input fields in the application.
///
/// This widget provides common text field functionality and styling that can be
/// extended by more specific field types. It includes support for validation,
/// labels, icons, and various text input properties.
class BaseTextFeild extends StatefulWidget {
  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// The text that describes the input field.
  final String label;

  /// An optional function that validates the input.
  ///
  /// Returns an error string if the input is invalid, or null if the input is valid.
  /// If null and [isRequired] is true, a default validator will be used.
  final String? Function(String?)? validator;

  /// Whether this field is required to be filled out.
  /// Defaults to false.
  final bool isRequired;

  /// Text that suggests what sort of input the field accepts.
  final String? hintText;

  /// An icon that appears before the input area and outside the decoration's container.
  final Widget? prefixIcon;

  /// An icon that appears after the input area and inside the decoration's container.
  final Widget? suffixIcon;

  /// The type of keyboard to use for editing the text.
  ///
  /// Defaults to [TextInputType.text] if not specified.
  final TextInputType? keyboardType;

  /// Whether to hide the text being edited (e.g., for passwords).
  /// Defaults to false.
  final bool obscureText;

  /// Whether to show input suggestions as the user types.
  /// Defaults to true.
  final bool enableSuggestions;

  /// Whether to enable automatic correction of the text.
  /// Defaults to true.
  final bool autocorrect;

  /// The maximum number of lines to show at one time.
  ///
  /// If this is 1 (the default), the text will be on a single line.
  /// If this is greater than 1, the text will be allowed to wrap to multiple lines.
  final int? maxLines;

  /// The maximum number of characters (Unicode scalar values) to allow in the text field.
  ///
  /// If set, a character counter will be displayed below the field
  /// showing how many characters have been entered.
  final int? maxLength;

  /// Creates a new [BaseTextFeild].
  ///
  /// The [label] parameter is required and describes the field's purpose.
  ///
  /// The [controller] can be used to control the text being edited. If not provided,
  /// the widget will create its own [TextEditingController].
  ///
  /// The [isRequired] parameter determines if the field must be filled out.
  /// When true, a red asterisk is shown next to the label.
  const BaseTextFeild({
    super.key,
    this.controller,
    required this.label,
    this.validator,
    this.isRequired = false,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.maxLines = 1,
    this.maxLength,
  });

  @override
  State<BaseTextFeild> createState() => _BaseTextFeildState();
}

class _BaseTextFeildState extends State<BaseTextFeild> {
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
          validator: widget.validator ?? 
              (widget.isRequired ? defaultValidator.textValidator : null),
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          enableSuggestions: widget.enableSuggestions,
          autocorrect: widget.autocorrect,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
            fillColor: Colors.grey[200],
            filled: true,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}
