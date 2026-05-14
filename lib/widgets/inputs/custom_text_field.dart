import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_style.dart';

/// FIXA reusable text field. Light-theme only, rounded 20px borders,
/// floating label support, prefix icon area, validator support.
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hint,
    this.label,
    this.icon,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.maxLines = 1,
    this.onChanged,
    this.onTap,
    this.validator,
    this.textInputAction,
    this.enabled = true,
    this.readOnly = false,
    this.focusNode,
  });

  /// Hint text shown when empty.
  final String? hint;

  /// Floating label.
  final String? label;

  /// Convenience: pass an icon and we'll wrap it as a prefix.
  final IconData? icon;

  /// Fully-custom prefix widget (takes precedence over [icon]).
  final Widget? prefixIcon;

  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final bool enabled;
  final bool readOnly;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final Widget? resolvedPrefix = prefixIcon ??
        (icon == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: 16, right: 12),
                child: IconTheme(
                  data: IconThemeData(
                    color: Colors.grey.shade600,
                    size: 22,
                  ),
                  child: Icon(icon),
                ),
              ));

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction ?? TextInputAction.next,
      maxLines: obscureText ? 1 : maxLines,
      onChanged: onChanged,
      onTap: onTap,
      enabled: enabled,
      readOnly: readOnly,
      validator: validator ?? (String? _) => null,
      cursorColor: AppColors.primary,
      style: appStyle(
        14,
        enabled ? AppColors.textPrimary : Colors.grey.shade600,
        FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: resolvedPrefix,
        suffixIcon: suffixIcon,
        label: label != null ? Text(label!) : null,
        labelStyle: appStyle(14, Colors.grey.shade600, FontWeight.w500),
        floatingLabelStyle: appStyle(12, AppColors.primary, FontWeight.w600),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 20,
        ),
        hintStyle: appStyle(
          14,
          enabled ? Colors.grey.shade600 : Colors.grey.shade400,
          FontWeight.w400,
        ).copyWith(letterSpacing: -0.05, height: 1.4),
        helperStyle: appStyle(12, Colors.grey.shade500, FontWeight.w400),
        errorStyle: appStyle(12, AppColors.error, FontWeight.w500),
        errorMaxLines: 2,
        border: _inputBorder(),
        enabledBorder: _inputBorder(),
        focusedBorder: _focusedBorder(),
        errorBorder: _errorBorder(),
        focusedErrorBorder: _errorBorder(),
        disabledBorder: _inputBorder(color: Colors.grey.shade300),
        filled: true,
        fillColor: enabled ? Colors.white : Colors.grey.shade50,
      ),
    );
  }

  OutlineInputBorder _inputBorder({Color? color}) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: color ?? Colors.grey.shade200,
          width: 1,
        ),
      );

  OutlineInputBorder _focusedBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      );

  OutlineInputBorder _errorBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: AppColors.error, width: 1),
      );
}
