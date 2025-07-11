import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:quform/text_feild/util/validators.dart';

/// A specialized text field for phone number input with built-in validation
/// and optional country code display.
///
/// This widget provides a user-friendly way to enter phone numbers with:
/// - Phone number keyboard by default
/// - Input filtering for digits only
/// - Optional country code display
/// - Built-in phone number validation
class PhoneNumberTextFeild extends StatefulWidget {
  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// The text that describes the phone number input field.
  final String label;

  /// An optional function that validates the phone number input.
  ///
  /// If provided, this overrides the default phone number validation.
  /// Returns an error string if the phone number is invalid, or null if valid.
  final String? Function(String?)? validator;

  /// Whether this field is required to be filled out.
  ///
  /// When true, a red asterisk is shown next to the label and
  /// the field cannot be submitted empty.
  /// Defaults to false.
  final bool isRequired;

  /// The country code to display as a prefix to the phone number.
  ///
  /// If provided, the country code will be displayed in a non-editable
  /// container to the left of the input field.
  /// Example: "+1" for US/Canada
  final String? countryCode;

  /// Creates a new [PhoneNumberTextFeild].
  ///
  /// The [label] parameter is required and describes the field's purpose.
  ///
  /// The [controller] can be used to control the text being edited. If not provided,
  /// the widget will create its own [TextEditingController].
  ///
  /// The [isRequired] parameter determines if the field must be filled out.
  ///
  /// The [countryCode] can be provided to show a country code prefix.
  const PhoneNumberTextFeild({
    super.key,
    this.controller,
    required this.label,
    this.validator,
    this.isRequired = false,
    this.countryCode,
  });

  @override
  State<PhoneNumberTextFeild> createState() => _PhoneNumberTextFeildState();
}

class _PhoneNumberTextFeildState extends State<PhoneNumberTextFeild> {
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
        Row(
          children: [
            if (widget.countryCode != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  ),
                ),
                child: Text(
                  widget.countryCode!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            Expanded(
              child: TextFormField(
                key: widget.key,
                controller: widget.controller,
                validator: widget.validator ?? defaultValidator.phoneNumberValidator,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  hintText: "Enter phone number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: widget.countryCode != null
                          ? Radius.zero
                          : Radius.circular(24),
                      right: Radius.circular(24),
                    ),
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}