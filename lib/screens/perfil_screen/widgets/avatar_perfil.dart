import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../widgets/badge_estado.dart';

// Foto, nombre y rol del usuario
class AvatarPerfil extends StatelessWidget {
  final String nombre;
  final String rol;

  const AvatarPerfil({super.key, required this.nombre, required this.rol});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 44,
          backgroundColor: AppColors.caramel.withValues(alpha: 0.4),
          child: const Icon(Icons.person, size: 48, color: AppColors.primary),
        ),
        const SizedBox(height: 12),
        Text(
          nombre,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.gray900),
        ),
        const SizedBox(height: 6),
        BadgeEstado(texto: rol, color: AppColors.secondary),
      ],
    );
  }
}
