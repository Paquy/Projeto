import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputCustomizado extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final bool obscure;
  final bool autofocus;
  final TextInputType type;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;

  InputCustomizado({
    this.controller,
    required this.hint,
    this.obscure = false,
    this.autofocus = false,
    this.type = TextInputType.text,
    List<dynamic>? inputFormatters,
    this.maxLines = 1,
    FormFieldValidator<String>? validator,
    FormFieldSetter<String>? onSaved,
  })  : inputFormatters = inputFormatters?.map((dynamic formatter) {
          if (formatter is TextInputFormatter) {
            return formatter;
          }
          return FilteringTextInputFormatter.deny('');
        }).toList(),
        validator = validator,
        onSaved = onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      autofocus: autofocus,
      keyboardType: type,
      inputFormatters: inputFormatters,
      validator: validator,
      maxLines: maxLines,
      onSaved: onSaved,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
