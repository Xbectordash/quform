import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:quform/text_feild/util/validators.dart';

class PhoneNumberTextFeild extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String? Function(String?)? validator;
  final bool isRequired;
  final String? countryCode;

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