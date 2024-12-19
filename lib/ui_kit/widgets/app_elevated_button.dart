import 'package:PP_787/ui_kit/colors.dart';
import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:PP_787/utils/constants.dart';
import 'package:flutter/material.dart';


class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.isActive = true,
    this.textColor = AppColors.white,
    this.backgroundColor = AppColors.primary, this.height = 54,
  });

  final String buttonText;
  final void Function() onTap;
  final bool isActive;
  final Color textColor;
  final Color backgroundColor;
  final int height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onTap : null,
      behavior: HitTestBehavior.translucent,
      child: AnimatedContainer(
        duration: AppConstants.duration200,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 16,
              color: AppColors.black.withOpacity(0.1),
            ),
          ],
          borderRadius: BorderRadius.circular(64),
          color: isActive ? backgroundColor : backgroundColor.withOpacity(0.5),
        ),
        height: height.toDouble(),
        // padding: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        child: Center(
          child: Text(
            buttonText,
            style: AppStyles.bodyMedium.apply(
              color: isActive ? textColor : textColor,
            ),
          ),
        ),
      ),
    );
  }
}
