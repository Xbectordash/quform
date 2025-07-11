import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:quform/text_feild/util/validators.dart';

/// A specialized text field for numeric input with number pad keyboard.
///
/// This widget provides a user-friendly way to enter numbers with:
/// - Numeric keyboard by default
/// - Built-in number validation
/// - Required field validation
/// - Custom validation support
class NumberTextFeild extends StatefulWidget {
  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// The text that describes the number input field.
  final String label;

  /// An optional function that validates the number input.
  ///
  /// If provided, this overrides the default number validation.
  /// Returns an error string if the number is invalid, or null if valid.
  final String? Function(String?)? validator;

  /// Whether this field is required to be filled out.
  ///
  /// When true, a red asterisk is shown next to the label and
  /// the field cannot be submitted empty.
  /// Defaults to false.
  final bool isRequired;

  /// Creates a new [NumberTextFeild].
  ///
  /// The [label] parameter is required and describes the field's purpose.
  ///
  /// The [controller] can be used to control the text being edited. If not provided,
  /// the widget will create its own [TextEditingController].
  ///
  /// The [isRequired] parameter determines if the field must be filled out.
  const NumberTextFeild({
    super.key,
    this.controller,
    required this.label,
    this.validator,
    this.isRequired = false,
  });

  @override
  State<NumberTextFeild> createState() => _NumberTextFeildState();
}

class _NumberTextFeildState extends State<NumberTextFeild> {
  @override
  Widget build(BuildContext context) {
    final defaultValidator = Validators();
    return Column(
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
          validator: defaultValidator.numberValidator,
          keyboardType: TextInputType.numberWithOptions(),
          enableSuggestions: true,
          decoration: InputDecoration(
            hint: Text("e.g. 1234567890"),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
            fillColor: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
