import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/typography/app_text_styles.dart';
import '../../../core/utils/responsive_util.dart';

/// Design-system text input with validation, password toggle, and icon support.
class AppTextInput extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool showPasswordToggle;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;
  final int? maxLines;

  const AppTextInput({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.showPasswordToggle = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.maxLines = 1,
  });

  @override
  State<AppTextInput> createState() => _AppTextInputState();
}

class _AppTextInputState extends State<AppTextInput> {
  late bool _obscured;

  @override
  void initState() {
    super.initState();
    _obscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _obscured,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      style: AppTextStyles.inputText(context),
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: context.scaleFontSize(14),
          color: AppColors.silverSecondaryLabel,
        ),
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: AppColors.silverPlaceholder,
                size: 20,
              )
            : null,
        suffixIcon: _buildSuffix(),
      ),
    );
  }

  Widget? _buildSuffix() {
    if (widget.showPasswordToggle) {
      return IconButton(
        icon: Icon(
          _obscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: AppColors.silverPlaceholder,
          size: 20,
        ),
        onPressed: () => setState(() => _obscured = !_obscured),
      );
    }
    return widget.suffixIcon;
  }
}
