import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class CustomButon extends StatelessWidget {
  const CustomButon({
    super.key,
    required this.title,
    required this.onTap,
    this.width = double.infinity,
    this.borderColor,
    this.textColor,
    this.shadowColor,
    this.gradientColor1,
    this.gradientColor2,
    this.height,
  });
  final double? height;
  final String title;
  final double? width;
  final Color? borderColor;
  final Color? textColor;
  final Color? shadowColor;
  final Color? gradientColor1;
  final Color? gradientColor2;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 12),

        decoration: BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: shadowColor?.withValues(alpha: 0.35) ?? Colors.transparent,
              blurRadius: 12,
              spreadRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
          gradient: LinearGradient(
            colors: [
              gradientColor1 ?? AppColors.primaryOrange,
              gradientColor2 ?? AppColors.orangeLight,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: textColor),
        ),
      ),
    );
  }
}
