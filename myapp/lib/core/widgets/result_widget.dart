import 'package:calcvio/core/utils/Appcolors.dart';
import 'package:calcvio/features/presentation/provider/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget resultTile(String label, String value, BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color:
                  themeProvider.isDarkMode
                      ? AppColors.darkTextSecondary
                      : Colors.black54,
            ),
          ),
        ),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}
