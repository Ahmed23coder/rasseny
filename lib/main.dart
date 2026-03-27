import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants/supabase_constants.dart';
import 'core/di/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/size_config.dart';
import 'features/auth/logic/auth_bloc.dart';
import 'features/auth/logic/auth_event.dart';
import 'features/onboarding/presentation/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: SupabaseConstants.supabaseUrl,
    anonKey: SupabaseConstants.supabaseAnonKey,
  );

  await initServiceLocator();
  runApp(const RassenyApp());
}

class RassenyApp extends StatelessWidget {
  const RassenyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>()..add(const AuthStarted()),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
