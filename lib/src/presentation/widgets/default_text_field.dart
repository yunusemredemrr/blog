import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final String hintText;
  final bool? obscureText;
  final String? errorText;
  final String labelText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function? suffixIconOnTap;

  const DefaultTextField({
    Key? key,
    required this.prefixIcon,
    required this.hintText,
    required this.labelText,
    required this.controller,
    this.keyboardType,
    this.onChanged,
    this.suffixIcon,
    this.suffixIconOnTap,
    this.obscureText = false,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText!,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        hintText: hintText,
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: () {
            if (suffixIconOnTap != null) {
              suffixIconOnTap!();
            }
          },
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Icon(prefixIcon),
        ),
        contentPadding:
            const EdgeInsets.only(left: 48.0, top: 19.0, bottom: 19),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
