import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';

/// Gradient CTA button for onboarding.
///
/// Shows "NEXT →" on pages 1–2, "GET STARTED" on the last page.
class OnboardingButton extends StatelessWidget {
  const OnboardingButton({
    super.key,
    required this.isLastPage,
    required this.onPressed,
  });

  final bool isLastPage;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isLastPage ? double.infinity : null,
      child: Material(
        borderRadius: BorderRadius.circular(28),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [AppColors.silver, AppColors.buttonDark],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 48,
                vertical: isLastPage ? 20 : 20,
              ),
              child: Row(
                mainAxisSize: isLastPage ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLastPage ? AppStrings.getStarted : AppStrings.next,
                    style: GoogleFonts.inter(
                      color: AppColors.buttonDark,
                      fontSize: isLastPage ? 16 : 12.8,
                      fontWeight: FontWeight.w700,
                      letterSpacing: isLastPage ? 1.6 : 1.92,
                    ),
                  ),
                  if (!isLastPage) ...[
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.arrow_forward,
                      color: AppColors.buttonDark,
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
