import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../colors.dart';
import '../text_styles.dart';

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
