import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/theme/app_colors.dart';

enum TextFieldType { text, email, password, phone, number }

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final TextFieldType type;
  final double? height;
  final double? width;
  final int? maxLines;
  final bool enabled;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.type = TextFieldType.text,
    this.height = 50,
    this.width = double.infinity,
    this.maxLines = 1,
    this.enabled = true,
    this.keyboardType,
    this.validator,
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.type == TextFieldType.password;
  }

  IconData _getDefaultPrefixIcon() {
    switch (widget.type) {
      case TextFieldType.email:
        return CupertinoIcons.mail;
      case TextFieldType.password:
        return CupertinoIcons.lock;
      case TextFieldType.phone:
        return CupertinoIcons.phone;
      case TextFieldType.number:
        return CupertinoIcons.number;
      default:
        return CupertinoIcons.person;
    }
  }

  TextInputType _getKeyboardType() {
    if (widget.keyboardType != null) return widget.keyboardType!;

    switch (widget.type) {
      case TextFieldType.email:
        return TextInputType.emailAddress;
      case TextFieldType.phone:
        return TextInputType.phone;
      case TextFieldType.number:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }

  String _getDefaultHint() {
    if (widget.hintText != null) return widget.hintText!;

    switch (widget.type) {
      case TextFieldType.password:
        return "•••••••••";
      default:
        return "";
    }
  }

  Widget? _buildSuffixIcon() {
    // Si c'est un champ mot de passe, ajouter l'icône toggle
    if (widget.type == TextFieldType.password) {
      return IconButton(
        icon: Icon(
          _obscureText ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }

    // Sinon, utiliser l'icône personnalisée si fournie
    if (widget.suffixIcon != null) {
      return IconButton(
        icon: Icon(widget.suffixIcon),
        onPressed: widget.onSuffixIconPressed,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: widget.width,
      decoration: BoxDecoration(
        color: AppColors.backgroundTertiary,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 0.0),
            child: Icon(_getDefaultPrefixIcon()),
          ),
          Expanded(
            child: TextField(
              controller: widget.controller,
              obscureText:
                  widget.type == TextFieldType.password && _obscureText,
              obscuringCharacter: "•",
              enabled: widget.enabled,
              maxLines: widget.type == TextFieldType.password
                  ? 1
                  : widget.maxLines,
              keyboardType: _getKeyboardType(),
              onChanged: widget.onChanged,
              style: TextStyle(
                fontSize: 18,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: _getDefaultHint(),
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: AppColors.textDisabled,
                ),
                suffixIcon: _buildSuffixIcon(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
