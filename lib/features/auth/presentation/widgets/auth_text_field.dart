import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';

/// Reusable dark-themed text field for the auth flow.
///
/// Pill-shaped with floating label, supports obscure toggle and error state.
class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.label,
    this.hint = '',
    this.controller,
    this.obscureText = false,
    this.onToggleObscure,
    this.errorText,
    this.keyboardType,
    this.onChanged,
  });

  final String label;
  final String hint;
  final TextEditingController? controller;
  final bool obscureText;
  final VoidCallback? onToggleObscure;
  final String? errorText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  bool get _hasError => errorText != null && errorText!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: _hasError
                  ? AppColors.errorText
                  : AppColors.labelBlue,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.2,
            ),
          ),
        ),

        // Input field
        Container(
          decoration: BoxDecoration(
            color: AppColors.inputFill,
            borderRadius: BorderRadius.circular(9999),
            border: Border.all(
              color: _hasError
                  ? AppColors.error
                  : AppColors.inputBorderBlue.withValues(alpha: 0.3),
            ),
            boxShadow: _hasError
                ? [
                    BoxShadow(
                      color: AppColors.error.withValues(alpha: 0.1),
                      blurRadius: 12,
                      spreadRadius: 0,
                    ),
                  ]
                : null,
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            onChanged: onChanged,
            style: GoogleFonts.inter(
              color: AppColors.textPrimary,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.inter(
                color: AppColors.hintText.withValues(alpha: 0.4),
                fontSize: 16,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 19,
              ),
              border: InputBorder.none,
              suffixIcon: onToggleObscure != null
                  ? IconButton(
                      icon: Icon(
                        obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.hintText.withValues(alpha: 0.6),
                        size: 20,
                      ),
                      onPressed: onToggleObscure,
                    )
                  : null,
            ),
          ),
        ),

        // Error text
        if (_hasError)
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: AppColors.error,
                  size: 14,
                ),
                const SizedBox(width: 6),
                Text(
                  errorText!,
                  style: GoogleFonts.inter(
                    color: AppColors.error,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
