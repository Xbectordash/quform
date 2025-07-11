import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:quform/text_feild/util/validators.dart';

class EmailTextFeild extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String? Function(String?)? validator;
  final bool isRequired;

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