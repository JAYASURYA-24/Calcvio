import 'package:calcvio/features/presentation/provider/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeToggleIcon extends StatelessWidget {
  const ThemeToggleIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    final isDark = provider.isDarkMode;

    return IconButton(
      icon: Icon(
        isDark ? Icons.light_mode : Icons.dark_mode,
        color: isDark ? Colors.white : Colors.black,
      ),
      tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
      onPressed: () {
        provider.toggleTheme(!isDark);
      },
    );
  }
}
