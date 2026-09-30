import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

// Una fila del perfil (correo, editar perfil, cerrar sesión...)
class OpcionPerfil extends StatelessWidget {
  final IconData icono;
  final String texto;
  final VoidCallback? onTap;
  final bool esPeligro; // true = se muestra en rojo

  const OpcionPerfil({
    super.key,
    required this.icono,
    required this.texto,
    this.onTap,
    this.esPeligro = false,
  });

  @override
  Widget build(BuildContext context) {
    Color color = AppColors.gray900;
    if (esPeligro) {
      color = AppColors.error;
    }

    return Card(
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        onTap: onTap,
        leading: Icon(icono, color: color),
        title: Text(texto, style: TextStyle(color: color)),
      ),
    );
  }
}
