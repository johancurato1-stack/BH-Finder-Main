import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool isPasswordField;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.isPasswordField = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPasswordField;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obscureText,
      keyboardType: widget.keyboardType,
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.secondary,
        fontFamily: 'Roboto',
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,

        floatingLabelBehavior: FloatingLabelBehavior.never,

        contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),

        prefixIcon: Icon(widget.prefixIcon, color: AppColors.secondary),

        suffixIcon: widget.isPasswordField
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.tertiary,
                ),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              )
            : null,

        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.tertiary, width: 0.5),
        ),

        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary, width: 0.5),
        ),

        labelStyle: const TextStyle(
          fontSize: 14,
          color: AppColors.tertiary,
          fontFamily: 'Roboto',
        ),

        hintStyle: const TextStyle(
          fontSize: 14,
          color: AppColors.tertiary,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}
