import 'package:flutter/material.dart';

/// Définition des couleurs de l'application
class AppColors {
  // ============ Couleurs de base ============
  static const Color black = Colors.black;
  static const Color white = Colors.white;

  // ============ Couleur principale (Vert) ============
  /// Vert très foncé - Pour les textes sur fond clair
  static const Color primary950 = Color(0xFF18230F);

  /// Vert foncé - Pour les headers, sections importantes
  static const Color primary900 = Color(0xFF27391C);

  /// Vert moyen - Couleur principale de l'app
  static const Color primary600 = Color(0xFF255F38);

  /// Vert émeraude - Pour les CTA, boutons principaux
  static const Color primary500 = Color(0xFF1F7D53);

  /// Vert clair - Pour les hover, états actifs
  static const Color primary400 = Color(0xFF2A9D6A);

  /// Vert très clair - Pour les backgrounds légers
  static const Color primary200 = Color(0xFF85D4AE);

  /// Vert pastel - Pour les backgrounds subtils
  static const Color primary100 = Color(0xFFCCEFE0);

  /// Vert ultra clair - Pour les surfaces
  static const Color primary50 = Color(0xFFE6F7F0);

  // ============ Couleurs neutres (Gris) ============
  static const Color neutral950 = Color(0xFF0A0A0A);
  static const Color neutral900 = Color(0xFF171717);
  static const Color neutral800 = Color(0xFF262626);
  static const Color neutral700 = Color(0xFF404040);
  static const Color neutral600 = Color(0xFF525252);
  static const Color neutral500 = Color(0xFF737373);
  static const Color neutral400 = Color(0xFFA3A3A3);
  static const Color neutral300 = Color(0xFFD4D4D4);
  static const Color neutral200 = Color(0xFFE5E5E5);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral50 = Color(0xFFFAFAFA);

  // ============ Couleurs fonctionnelles ============
  /// Succès (vert)
  static const Color success = Color(0xFF1F7D53);
  static const Color successLight = Color(0xFFE6F7F0);

  /// Erreur (rouge)
  static const Color error = Color(0xFFDC2626);
  static const Color errorLight = Color(0xFFFEE2E2);

  /// Avertissement (orange)
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);

  /// Information (bleu)
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDCEDFE);

  // ============ Couleurs d'interface ============
  /// Backgrounds
  static const Color background = Color(0xFFFFFFFF);
  static const Color card = Color(0x64CCEFE0);
  static const Color backgroundSecondary = Color(0xFFF9FAFB);
  static const Color backgroundTertiary = Color(0xFFF3F4F6);

  /// Surfaces
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceElevated = Color(0xFFF9FAFB);

  /// Bordures
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderLight = Color(0xFFF3F4F6);
  static const Color borderDark = Color(0xFFD1D5DB);

  /// Dividers
  static const Color divider = Color(0xFFE5E7EB);
  static const Color greenDivider = Color(0xFFD2E3D8);

  /// Overlay / Shadow
  static const Color overlay = Color(0x1A000000); // 10% noir
  static const Color shadow = Color(0x0D000000); // 5% noir

  // ============ Couleurs de texte ============
  static const Color textPrimary = Color(0xFF18230F);
  static const Color textSecondary = Color(0xFF525252);
  static const Color textTertiary = Color(0xFF737373);
  static const Color textDisabled = Color(0xFFA3A3A3);
  static const Color textOnPrimary = Color(0xFFFFFFFF); // Texte sur bouton vert
  static const Color textOnDark = Color(0xFFFFFFFF);

  // ============ Couleurs d'état ============
  /// Disabled
  static const Color disabled = Color(0xFFF5F5F5);
  static const Color disabledText = Color(0xFFA3A3A3);

  /// Hover (pour web/desktop)
  static const Color hover = Color(0xFF2A9D6A);

  /// Pressed/Active
  static const Color pressed = Color(0xFF255F38);

  /// Focus
  static const Color focus = Color(0xFF1F7D53);

  // ============ Couleurs spécifiques (si besoin) ============
  /// Badge / Notification
  static const Color badge = Color(0xFFDC2626);

  /// Link
  static const Color link = Color(0xFF1F7D53);
  static const Color linkHover = Color(0xFF255F38);
}
