import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../models/usuario.dart';
import '../../../widgets/badge_estado.dart';
import '../../../widgets/tarjeta_item.dart';

// Tarjeta de un usuario con interruptor para activarlo o desactivarlo
class TarjetaUsuario extends StatelessWidget {
  final Usuario usuario;
  final ValueChanged<bool> onCambiarActivo;

  const TarjetaUsuario(
      {super.key, required this.usuario, required this.onCambiarActivo});

  @override
  Widget build(BuildContext context) {
    Color colorRol = AppColors.gray700;
    if (usuario.rol == 'Administrador') {
      colorRol = AppColors.secondary;
    }

    Color colorIcono = AppColors.gray500;
    if (usuario.activo) {
      colorIcono = AppColors.primary;
    }

    return TarjetaItem(
      icono: Icons.person_outline,
      colorIcono: colorIcono,
      titulo: usuario.nombre,
      subtitulo: usuario.email,
      extra: BadgeEstado(texto: usuario.rol, color: colorRol),
      derecha: Switch(
        value: usuario.activo,
        activeTrackColor: AppColors.success,
        onChanged: onCambiarActivo,
      ),
    );
  }
}
