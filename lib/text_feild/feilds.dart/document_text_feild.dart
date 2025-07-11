import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quform/text_feild/util/validators.dart';

/// A specialized text field for document number input with validation.
///
/// This widget is designed for entering document numbers (e.g., ID, passport, etc.)
/// with the following features:
/// - Document number validation
/// - Custom document type support
/// - Required field validation
/// - Disabled auto-correction and suggestions by default
class DocumentTextFeild extends StatefulWidget {
  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// The text that describes the document input field.
  final String label;

  /// An optional function that validates the document number input.
  ///
  /// If provided, this overrides the default document validation.
  /// Returns an error string if the document number is invalid, or null if valid.
  final String? Function(String?)? validator;

  /// Whether this field is required to be filled out.
  ///
  /// When true, a red asterisk is shown next to the label and
  /// the field cannot be submitted empty.
  /// Defaults to false.
  final bool isRequired;

  /// The type of document this field is for (e.g., 'passport', 'ID', 'license').
  ///
  /// This is used in the hint text to guide the user.
  /// Defaults to 'document'.
  final String documentType;

  /// Creates a new [DocumentTextFeild].
  ///
  /// The [label] parameter is required and describes the field's purpose.
  ///
  /// The [controller] can be used to control the text being edited. If not provided,
  /// the widget will create its own [TextEditingController].
  ///
  /// The [isRequired] parameter determines if the field must be filled out.
  ///
  /// The [documentType] parameter specifies the type of document for hint text.
  const DocumentTextFeild({
    super.key,
    this.controller,
    required this.label,
    this.validator,
    this.isRequired = false,
    this.documentType = 'document',
  });

  @override
  State<DocumentTextFeild> createState() => _DocumentTextFeildState();
}

class _DocumentTextFeildState extends State<DocumentTextFeild> {
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
          validator: widget.validator ?? defaultValidator.documentFieldValidator,
          keyboardType: TextInputType.text,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: "Enter your ${widget.documentType} number",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
            fillColor: Colors.grey[200],
            filled: true,
            suffixIcon: Icon(Icons.description, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}