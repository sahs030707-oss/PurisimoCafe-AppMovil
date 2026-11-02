import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

// Una fila del perfil (correo, sucursal, cerrar sesión...)
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
    Color color = AppTema.texto(context);
    if (esPeligro) {
      color = AppColors.error;
    }

    return Card(
      color: AppTema.tarjeta(context),
      elevation: 0,
      child: ListTile(
        onTap: onTap,
        leading: Icon(icono, color: color),
        title: Text(texto, style: TextStyle(color: color)),
      ),
    );
  }
}
