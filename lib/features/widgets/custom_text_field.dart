
import 'package:flutter/material.dart';

import '../../utils/constants/colors_code.dart';
import '../../utils/constants/fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final Widget? child;


  const CustomTextField({
    super.key,
     this.controller,
     this.labelText,
     this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.validator,
    this.prefixIcon,
    this.onChanged,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText!,
          style: TextStyle(
            fontSize: 14,
            fontFamily: Fonts.getFontFamilyTitillRegular(),
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: ColorsCode.whiteColor100,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              fontFamily: Fonts.getFontFamilyTitillRegular(),
              color: ColorsCode.grayColor,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.purple.shade100,
              ),
            ),
            suffixIcon: suffixIcon,
          ),
          textInputAction: TextInputAction.done,
          validator: validator,
        ),
      ],
    );
  }
}