import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors.dart';
import '../text_styles.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.hint,
    this.initialValue,
    required this.onChanged,
    this.formatters,
    this.keyboardType,
    this.center = false,
    this.controller, this.minLines = 1,
  });

  final String hint;
  final String? initialValue;
  final void Function(String) onChanged;
  final List<TextInputFormatter>? formatters;
  final TextInputType? keyboardType;
  final bool center;
  final TextEditingController? controller;
  final int minLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLines,
      maxLines: minLines,
      controller: controller,
      initialValue: initialValue,
      // style: AppStyles.bodySmall.apply(color: AppColors.black),
      cursorHeight: 20,
      cursorWidth: 1,
      onChanged: onChanged,
      keyboardType: keyboardType,
      textAlign: center ? TextAlign.center : TextAlign.start,
      inputFormatters: formatters,
      decoration: InputDecoration(

        contentPadding: const EdgeInsets.all(10),
        isDense: true,
        // hintStyle: AppStyles.bodySmall.apply(color: AppColors.black.withOpacity(.5)),
        hintText: hint,
        filled: true,
        fillColor: AppColors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
