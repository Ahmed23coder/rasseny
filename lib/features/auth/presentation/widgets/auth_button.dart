import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';

/// Primary and gradient auth buttons matching the Rasseny design system.
class AuthButton extends StatefulWidget {
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
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _isPressed ? 0.95 : 1.0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOutCubic,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28 * 1.0), // Kept 28px standard
          gradient: widget.isPrimary
              ? null
              : const LinearGradient(
                  begin: Alignment(-0.7, -0.7),
                  end: Alignment(0.7, 0.7),
                  colors: [AppColors.labelBlue, AppColors.navyButton],
                ),
          color: widget.isPrimary ? AppColors.silverGold : null,
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
            onTap: widget.isLoading ? null : widget.onPressed,
            onHighlightChanged: (isHighlighted) {
              if (!widget.isLoading && widget.onPressed != null) {
                setState(() => _isPressed = isHighlighted);
              }
            },
            borderRadius: BorderRadius.circular(28),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: widget.isLoading
                  ? Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: widget.isPrimary
                              ? AppColors.navyButton
                              : AppColors.textPrimary,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.label,
                          style: GoogleFonts.inter(
                            color: widget.isPrimary
                                ? AppColors.navyButton
                                : AppColors.textPrimary,
                            fontSize: widget.isPrimary ? 16 : 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: widget.isPrimary ? 0.4 : 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (widget.icon != null) ...[
                          const SizedBox(width: 12),
                          Icon(
                            widget.icon,
                            color: widget.isPrimary
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
      ),
    );
  }
}
