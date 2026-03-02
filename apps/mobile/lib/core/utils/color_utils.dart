import 'package:flutter/material.dart';

class ColorUtils {
  const ColorUtils._();

  static Color fromHex(String hex) {
    final normalized = hex.replaceAll('#', '');
    if (normalized.length != 6) {
      return const Color(0xFF8E8E93);
    }
    return Color(int.parse('FF$normalized', radix: 16));
  }

  static String toHex(Color color) {
    final value = color
        .toARGB32()
        .toRadixString(16)
        .padLeft(8, '0')
        .toUpperCase();
    return '#${value.substring(2)}';
  }
}
