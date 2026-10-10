import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'app/router.dart';
import 'app/providers.dart';

void main() {
  runApp(const ProviderScope(child: RoamAgentApp()));
}

class RoamAgentApp extends ConsumerWidget {
  const RoamAgentApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final locale = ref.watch(currentLocaleProvider);

    return MaterialApp.router(
      title: 'RoamAgent',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routerConfig: router,
      locale: locale,
      supportedLocales: const [
        Locale('en', ''),
        Locale('te', ''),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
