import 'package:PP_787/ui_kit/colors.dart';
import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.hint,
    this.initialValue,
    required this.onChanged,
    this.formatters,
    this.keyboardType,
    this.center = false,
    this.controller,
    this.minLines = 1,
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
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 16,
            color: AppColors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: TextFormField(
        style: AppStyles.bodyMedium.copyWith(color: AppColors.gray),
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
          hintStyle: AppStyles.bodyMedium.copyWith(color: AppColors.gray),
          contentPadding: const EdgeInsets.all(16),
          isDense: true,
          // hintStyle: AppStyles.bodySmall.apply(color: AppColors.black.withOpacity(.5)),
          hintText: hint,
          filled: true,
          fillColor: AppColors.surface,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
