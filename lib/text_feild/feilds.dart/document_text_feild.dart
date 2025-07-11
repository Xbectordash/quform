import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quform/text_feild/util/validators.dart';

class DocumentTextFeild extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String? Function(String?)? validator;
  final bool isRequired;
  final String documentType;

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