import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/radius/app_radius.dart';

/// Shows a design-system modal bottom sheet with glass card + blurred overlay.
Future<T?> showAppModal<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isDismissible = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isDismissible: isDismissible,
    enableDrag: isDismissible,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.60),
    builder: (ctx) => AppModal(child: builder(ctx)),
  );
}

/// Glass-card container used inside [showAppModal].
class AppModal extends StatelessWidget {
  final Widget child;

  const AppModal({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppRadius.modalValue),
        topRight: Radius.circular(AppRadius.modalValue),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppRadius.modalValue),
              topRight: Radius.circular(AppRadius.modalValue),
            ),
            border: Border(
              top: BorderSide(color: Colors.white.withValues(alpha: 0.10)),
            ),
          ),
          child: SafeArea(top: false, child: child),
        ),
      ),
    );
  }
}
