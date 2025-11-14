import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/utils/extension.dart';
import 'package:todo/utils/utils.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final String? iconSuffix;
  final String? iconPrefix;
  final Widget? prefix;

  final VoidCallback? onPressed;
  final bool isLoading;
  final bool? disabled;

  final double? width;
  final double? height;

  final double? radius;

  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.backgroundColor,
    this.textColor,
    this.iconSuffix,
    this.iconPrefix,
    this.prefix,
    this.disabled,
    this.radius,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 44, // Hauteur fixe selon Figma
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 8),
        color: disabled == true
            ? AppColors.neutral200
            : backgroundColor ?? AppColors.primary500,
      ),
      child: MaterialButton(
        onPressed: disabled == true || isLoading ? null : onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefix != null && iconPrefix == null) ...[
                    prefix!,
                    8.horizontalSpace,
                  ],
                  if (iconPrefix != null && prefix == null) ...[
                    SvgPicture.asset(
                      iconPrefix!,
                      colorFilter: getColorFiler(textColor ?? Colors.white),
                    ),
                    8.horizontalSpace,
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontWeight: FontWeight.w500,
                      // fontFamily: AppFonts.montserrat,
                    ),
                  ),
                  if (iconSuffix != null) ...[
                    8.horizontalSpace,
                    SvgPicture.asset(
                      iconSuffix!,
                      colorFilter: getColorFiler(textColor ?? Colors.white),
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
