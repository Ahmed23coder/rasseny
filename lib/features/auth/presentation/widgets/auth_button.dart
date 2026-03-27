import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';

/// Primary and gradient auth buttons matching the Rasseny design system.
class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
    this.isLoading = false,
    this.icon,
  });

  /// Button label text.
  final String label;
  final VoidCallback? onPressed;

  /// `true` = Silver-gold fill with navy text.
  /// `false` = Gradient fill (slate-blue to navy) with light text.
  final bool isPrimary;
  final bool isLoading;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9999),
        gradient: isPrimary
            ? null
            : const LinearGradient(
                begin: Alignment(-0.7, -0.7),
                end: Alignment(0.7, 0.7),
                colors: [AppColors.labelBlue, AppColors.navyButton],
              ),
        color: isPrimary ? AppColors.silverGold : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(9999),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: isLoading
                ? Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: isPrimary
                            ? AppColors.navyButton
                            : AppColors.textPrimary,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: GoogleFonts.inter(
                          color: isPrimary
                              ? AppColors.navyButton
                              : AppColors.textPrimary,
                          fontSize: isPrimary ? 16 : 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: isPrimary ? 0.4 : 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (icon != null) ...[
                        const SizedBox(width: 12),
                        Icon(
                          icon,
                          color: isPrimary
                              ? AppColors.navyButton
                              : AppColors.textPrimary,
                          size: 16,
                        ),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
