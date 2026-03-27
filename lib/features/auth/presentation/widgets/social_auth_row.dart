import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';

/// Horizontally centered row of Social Auth buttons for Apple, Google, and Facebook.
/// Complies with the Obsidian stylistic tokens (28px border, subtle border blue).
class SocialAuthRow extends StatelessWidget {
  const SocialAuthRow({
    super.key,
    required this.onApplePressed,
    required this.onGooglePressed,
    required this.onFacebookPressed,
  });

  final VoidCallback onApplePressed;
  final VoidCallback onGooglePressed;
  final VoidCallback onFacebookPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildButton(
          onPressed: onGooglePressed,
          child: Text(
            'G',
            style: GoogleFonts.inter(
              color: AppColors.silver,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 16),
        _buildButton(
          onPressed: onFacebookPressed,
          child: const Icon(Icons.facebook, color: AppColors.silver, size: 24),
        ),
        const SizedBox(width: 16),
        _buildButton(
          onPressed: onApplePressed,
          child: const Icon(
            Icons.apple,
            color: AppColors.silver,
            size: 26,
            // Apple logo tends to look slightly smaller visually, hence size 26
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required VoidCallback onPressed,
    required Widget child,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.inputBorderBlue),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        minimumSize: const Size(64, 64),
        padding: EdgeInsets.zero, // Keep completely uniform
      ),
      child: child,
    );
  }
}
