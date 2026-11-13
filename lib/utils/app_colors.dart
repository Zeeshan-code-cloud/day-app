import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF5148D8),
      Color(0xFF3C79F5),
      Color(0xFF36D7FF),

    ],
  );


  static const Color shadowDark = Color(0x3310183E);

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF5B5FEF),
      Color(0xFF7C4DFF),
    ],
  );

  static const Color glassLight = Color(0x33FFFFFF); // 20%

  static const LinearGradient darkBackgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF18123F),
      Color(0xFF101D4C),
      Color(0xFF062D43),
    ],
  );
  static const Color darkTextMuted = Color(0xFF707A9C);
  static const Color white = Color(0xFFFFFFFF);


  static const Color darkTextSecondary = Color(0xFFA8B0CC);

  static bool get isDark => Get.isDarkMode;

  static Color get primary =>
      isDark ? const Color(0xFF7C73FF) : const Color(0xFF6C63FF);

  static Color get secondary =>
      isDark ? const Color(0xFFA89EFF) : const Color(0xFF8B7FFF);

  static Color get background =>
      isDark ? const Color(0xFF0F172A) : const Color(0xFFF8F9FD);

  static Color get surface =>
      isDark ? const Color(0xFF1E293B) : const Color(0xFFFFFFFF);

  static Color get card =>
      isDark ? const Color(0xFF263548) : const Color(0xFFFFFFFF);

  static Color get textPrimary =>
      isDark ? const Color(0xFFFFFFFF) : const Color(0xFF111827);

  static Color get textSecondary =>
      isDark ? const Color(0xFF94A3B8) : const Color(0xFF6B7280);

  static Color get border =>
      isDark ? const Color(0xFF334155) : const Color(0xFFE5E7EB);

  static Color get success => const Color(0xFF22C55E);

  static Color get warning => const Color(0xFFF59E0B);

  static Color get error => const Color(0xFFEF4444);

  static Color get shadow =>
      isDark
          ? Colors.black.withValues(alpha: 0.30)
          : Colors.black.withValues(alpha: 0.08);

  static Color get divider =>
      isDark ? const Color(0xFF334155) : const Color(0xFFE5E7EB);

  static Color get icon =>
      isDark ? const Color(0xFFE2E8F0) : const Color(0xFF374151);

  static Color get scaffold =>
      isDark ? const Color(0xFF0F172A) : const Color(0xFFF8F9FD);

 }