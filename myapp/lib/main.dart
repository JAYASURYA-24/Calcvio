import 'package:calcvio/core/utils/theme.dart';
import 'package:calcvio/features/presentation/dashboardScreen.dart/screen/dashboardPage.dart';
import 'package:calcvio/features/presentation/provider/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('isDarkMode') ?? false;

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(initialDarkMode: isDark),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calcvio',
      themeMode: provider.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const FinancialCalculatorTabs(), // Replace with your actual screen
    );
  }
}
