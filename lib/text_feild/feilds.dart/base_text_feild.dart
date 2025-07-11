import 'package:flutter/material.dart';
import 'package:quform/text_feild/util/validators.dart';

class BaseTextFeild extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String? Function(String?)? validator;
  final bool isRequired;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;
  final int? maxLines;
  final int? maxLength;

  BaseTextFeild({
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
