import 'package:fitnect/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

/// A reusable text form field with a label above it.
/// This can be used across all modules in the application.
class LabeledTextFormField extends StatelessWidget {
  final String title;
  final String hintText;
  final String? labelText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final Key? fieldKey;

  const LabeledTextFormField({
    super.key,
    required this.title,
    required this.hintText,
    this.labelText,
    this.controller,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.textInputAction,
    this.fieldKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: context.colors.neutral,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          key: fieldKey,
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
