import 'package:flutter/material.dart';
import 'package:todo/core/theme/app_colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final IconData? iconSuffix;
  final IconData? iconPrefix;

  final VoidCallback? onPressed;
  final bool isLoading;
  final bool? disabled;

  final double? width;
  final double? height;

  final double? radius;

  final Color? borderColor;
  final Color? textColor;
  final Color? backgroundColor;
  final double? borderWidth;

  const CustomOutlinedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.borderColor,
    this.textColor,
    this.backgroundColor,
    this.iconSuffix,
    this.iconPrefix,
    this.disabled,
    this.radius,
    this.height,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor = disabled == true
        ? Colors.grey.shade300
        : borderColor ?? AppColors.neutral300;

    final effectiveTextColor = disabled == true
        ? Colors.grey.shade400
        : textColor ?? AppColors.neutral800;

    return Container(
      height: height ?? 44,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 8),
        border: Border.all(
          color: effectiveBorderColor,
          width: borderWidth ?? 1.5,
        ),
        color: backgroundColor ?? Colors.transparent,
      ),
      child: MaterialButton(
        onPressed: disabled == true || isLoading ? null : onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 8),
        ),
        elevation: 0,
        highlightElevation: 0,
        splashColor: effectiveBorderColor.withOpacity(0.1),
        highlightColor: effectiveBorderColor.withOpacity(0.05),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(effectiveTextColor),
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (iconPrefix != null) ...[
                    Icon(iconPrefix, color: effectiveTextColor, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      color: effectiveTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  if (iconSuffix != null) ...[
                    const SizedBox(width: 8),
                    Icon(iconSuffix, color: effectiveTextColor, size: 20),
                  ],
                ],
              ),
      ),
    );
  }
}
