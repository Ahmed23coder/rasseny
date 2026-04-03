import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/colors/app_colors.dart';
import '../../../core/utils/app_animations.dart';
import '../../../core/utils/responsive_util.dart';

enum SocialType { google, facebook, apple }

/// Row/Column of social auth buttons (Google, Facebook, Apple).
class SocialAuthButtons extends StatelessWidget {
  final bool isSignUp;

  const SocialAuthButtons({super.key, this.isSignUp = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialButton(
          type: SocialType.google,
          onTap: () {},
        ),
        SizedBox(width: context.scaleWidth(16)),
        _SocialButton(
          type: SocialType.facebook,
          onTap: () {},
        ),
        SizedBox(width: context.scaleWidth(16)),
        _SocialButton(
          type: SocialType.apple,
          onTap: () {},
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final SocialType type;
  final VoidCallback onTap;

  const _SocialButton({
    required this.type,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return PressScaleAnimation(
      onTap: onTap,
      child: Container(
        height: context.scaleWidth(64),
        width: context.scaleWidth(64),
        decoration: BoxDecoration(
          color: AppColors.silver04,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: AppColors.silverBorder, width: 1.185),
        ),
        alignment: Alignment.center,
        child: _buildIcon(context),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    if (type == SocialType.google) {
      return FaIcon(
        FontAwesomeIcons.google,
        color: const Color(0xFFDB4437), // Google Red (using as primary)
        size: context.scaleWidth(28),
      );
    } else if (type == SocialType.facebook) {
      return FaIcon(
        FontAwesomeIcons.facebookF,
        color: const Color(0xFF1877F2), // Facebook Blue
        size: context.scaleWidth(28),
      );
    } else if (type == SocialType.apple) {
      return FaIcon(
        FontAwesomeIcons.apple,
        color: Colors.white,
        size: context.scaleWidth(32),
      );
    }
    return const SizedBox();
  }
}
