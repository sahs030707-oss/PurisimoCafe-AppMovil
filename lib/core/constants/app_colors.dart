import 'package:flutter/material.dart';

// Aquí están todos los colores de la app para no repetirlos en cada pantalla
class AppColors {
  static const Color primary = Color(0xFF6B4226);
  static const Color secondary = Color(0xFFA67C52);
  static const Color caramel = Color(0xFFC99A6B);
  static const Color success = Color(0xFF2E7D5B);
  static const Color warning = Color(0xFFD68B3D);
  static const Color error = Color(0xFFC94C4C);
  static const Color gray900 = Color(0xFF3B2B24);
  static const Color gray700 = Color(0xFF76665C);
  static const Color gray500 = Color(0xFFB9AAA0);
  static const Color gray200 = Color(0xFFE5DBD2);

  // Colores del modo oscuro
  static const Color fondoOscuro = Color(0xFF1E1A17);
  static const Color tarjetaOscura = Color(0xFF2B2420);
  static const Color fondoSuaveOscuro = Color(0xFF3A302A);
  static const Color textoSuaveOscuro = Color(0xFFD7C9BE);
}

// Colores que cambian según el modo (claro u oscuro)
class AppTema {
  // Pregunta si la app está en modo oscuro
  static bool esOscuro(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  // Fondo de las tarjetas
  static Color tarjeta(BuildContext context) {
    if (esOscuro(context)) {
      return AppColors.tarjetaOscura;
    }
    return Colors.white;
  }

  // Texto principal
  static Color texto(BuildContext context) {
    if (esOscuro(context)) {
      return Colors.white;
    }
    return AppColors.gray900;
  }

  // Texto secundario (más suave)
  static Color textoSuave(BuildContext context) {
    if (esOscuro(context)) {
      return AppColors.textoSuaveOscuro;
    }
    return AppColors.gray700;
  }

  // Fondos suaves (barras de búsqueda, selectores)
  static Color fondoSuave(BuildContext context) {
    if (esOscuro(context)) {
      return AppColors.fondoSuaveOscuro;
    }
    return AppColors.gray200;
  }
}
