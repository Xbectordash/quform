import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:quform/text_feild/util/validators.dart';

class NumberTextFeild extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String? Function(String?)? validator;
  final bool isRequired;

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
