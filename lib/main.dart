import 'package:flutter/material.dart';

import 'core/di/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/size_config.dart';
import 'features/onboarding/presentation/pages/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initServiceLocator();
  runApp(const RassenyApp());
}

class RassenyApp extends StatelessWidget {
  const RassenyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rasseny',
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        SizeConfig().init(context);
        return Theme(
          data: AppTheme.darkTheme,
          child: child!,
        );
      },
      home: const SplashPage(),
    );
  }
}
