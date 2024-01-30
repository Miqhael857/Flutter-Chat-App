import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final double height;
  final bool obscureText;
  final String? Function(String?)? validator;

  const AppTextFormField({
    super.key,
    required this.controller,
    this.keyboardType,
    required this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
    this.height = 65,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.r),
          ),
    
        ),
        
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon,
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }
}
