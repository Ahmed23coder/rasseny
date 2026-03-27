import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';

/// Real-time password strength meter with gradient bar.
class PasswordStrengthMeter extends StatelessWidget {
  const PasswordStrengthMeter({super.key, required this.password});

  final String password;

  @override
  Widget build(BuildContext context) {
    final strength = _calculateStrength(password);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Label row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SECURITY STRENGTH',
                style: GoogleFonts.inter(
                  color: AppColors.silver.withValues(alpha: 0.5),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              Text(
                strength.label,
                style: GoogleFonts.inter(
                  color: AppColors.labelBlue,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: Container(
              height: 4,
              width: double.infinity,
              color: AppColors.inputBorderBlue.withValues(alpha: 0.3),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: strength.progress,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9999),
                    gradient: const LinearGradient(
                      colors: [AppColors.inputBorderBlue, AppColors.silverGold],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _PasswordStrength _calculateStrength(String pwd) {
    if (pwd.isEmpty) return _PasswordStrength('', 0);
    if (pwd.length < 4) return _PasswordStrength('Fragile', 0.15);
    if (pwd.length < 6) return _PasswordStrength('Developing', 0.35);
    if (pwd.length < 8) return _PasswordStrength('Atmospheric', 0.65);
    // Check for mixed case + numbers + special chars
    final hasUpper = pwd.contains(RegExp(r'[A-Z]'));
    final hasDigit = pwd.contains(RegExp(r'[0-9]'));
    final hasSpecial = pwd.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    if (hasUpper && hasDigit && hasSpecial) {
      return _PasswordStrength('Authentic', 1.0);
    }
    if (hasUpper && hasDigit || hasUpper && hasSpecial || hasDigit && hasSpecial) {
      return _PasswordStrength('Atmospheric', 0.75);
    }
    return _PasswordStrength('Atmospheric', 0.65);
  }
}

class _PasswordStrength {
  const _PasswordStrength(this.label, this.progress);
  final String label;
  final double progress;
}
