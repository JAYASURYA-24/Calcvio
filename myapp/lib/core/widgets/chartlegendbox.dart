import 'package:flutter/material.dart';

Widget legendBox({
  required Color color,
  required String label,
  required String value,
}) {
  return Row(
    children: [
      Container(
        width: 12,
        height: 12,
        margin: const EdgeInsets.only(right: 6),
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          Text(value, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    ],
  );
}
