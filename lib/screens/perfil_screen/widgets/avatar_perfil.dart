import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../widgets/badge_estado.dart';

// Foto, nombre y rol del usuario
class AvatarPerfil extends StatelessWidget {
  final String nombre;
  final String rol;
  final bool oscuro; // true = modo oscuro activado

  const AvatarPerfil({
    super.key,
    required this.nombre,
    required this.rol,
    this.oscuro = false,
  });

  @override
  Widget build(BuildContext context) {
    Color colorNombre = AppColors.gray900;
    if (oscuro) {
      colorNombre = Colors.white;
    }

    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 44,
              backgroundColor: AppColors.caramel.withValues(alpha: 0.4),
              child:
                  const Icon(Icons.person, size: 48, color: AppColors.primary),
            ),
            // Iconito de cámara en la esquina
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child:
                    const Icon(Icons.camera_alt, color: Colors.white, size: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          nombre,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: colorNombre,
          ),
        ),
        const SizedBox(height: 6),
        BadgeEstado(texto: rol, color: AppColors.secondary),
      ],
    );
  }
}
