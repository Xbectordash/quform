import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quform/text_feild/util/validators.dart';

class PasswordTextFeild extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String? Function(String?)? validator;
  final bool isRequired;
  final bool showVisibilityToggle;

  const PasswordTextFeild({
    super.key,
    this.controller,
    required this.label,
    this.validator,
    this.isRequired = false,
    this.showVisibilityToggle = true,
  });

  @override
  State<PasswordTextFeild> createState() => _PasswordTextFeildState();
}

class _PasswordTextFeildState extends State<PasswordTextFeild> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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
          validator: widget.validator ?? defaultValidator.passwordValidator,
          obscureText: _obscureText,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: "Enter your password",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
            fillColor: Colors.grey[200],
            filled: true,
            suffixIcon: widget.showVisibilityToggle
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: _toggleVisibility,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}