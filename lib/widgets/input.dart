import 'package:flutter/material.dart';


class Input extends StatelessWidget {
  const Input({
    this.hintText = '',
    this.controller,
    this.errorText,
    this.obscureText = false,
    this.onTap,
    this.keyboardType,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.letterSpacing,
    this.helpText,
    this.onEditingComplete,
    this.suffixIcon,
    this.onChanged,
    this.initialValue,
  });

  final String hintText;
  final TextEditingController? controller;
  final String? errorText;
  final bool obscureText;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextAlign textAlign;
  final double? letterSpacing;
  final String? helpText;
  final Function()? onEditingComplete;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      style: TextStyle(letterSpacing: letterSpacing),
      textAlign: textAlign,
      maxLength: maxLength,
      onTap: onTap,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textInputAction: onEditingComplete == null
          ? TextInputAction.next
          : TextInputAction.done,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        isDense: true,
        counterText: "",
        errorText: errorText == '' ? null : errorText,
        errorMaxLines: 10,
        labelText: hintText,
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
      ),
    );
  }
}