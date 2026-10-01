import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

// Una fila del perfil (correo, sucursal, cerrar sesión...)
class OpcionPerfil extends StatelessWidget {
  final IconData icono;
  final String texto;
  final VoidCallback? onTap;
  final bool esPeligro; // true = se muestra en rojo
  final bool oscuro; // true = modo oscuro activado

  const OpcionPerfil({
    super.key,
    required this.icono,
    required this.texto,
    this.onTap,
    this.esPeligro = false,
    this.oscuro = false,
  });

  @override
  Widget build(BuildContext context) {
    Color color = AppColors.gray900;
    Color fondo = Colors.white;
    if (oscuro) {
      color = Colors.white;
      fondo = const Color(0xFF2A2A2A);
    }
    if (esPeligro) {
      color = AppColors.error;
    }

    return Card(
      color: fondo,
      elevation: 0,
      child: ListTile(
        onTap: onTap,
        leading: Icon(icono, color: color),
        title: Text(texto, style: TextStyle(color: color)),
      ),
    );
  }
}
