import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/typography/app_text_styles.dart';

/// Generic stub screen used for routes that are not yet built.
class StubScreen extends StatelessWidget {
  final String title;
  const StubScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: Text(title, style: AppTextStyles.h2(context))),
    );
  }
}
