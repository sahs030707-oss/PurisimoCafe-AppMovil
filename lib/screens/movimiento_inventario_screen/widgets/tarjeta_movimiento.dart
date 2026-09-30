import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../models/movimiento.dart';
import '../../../widgets/tarjeta_item.dart';

// Tarjeta de una merma (producto dañado, caducado o perdido)
class TarjetaMovimiento extends StatelessWidget {
  final Movimiento movimiento;

  const TarjetaMovimiento({super.key, required this.movimiento});

  @override
  Widget build(BuildContext context) {
    // Icono y color según el motivo
    IconData icono = Icons.search_off;
    Color color = AppColors.gray700;
    if (movimiento.motivo == 'Dañado') {
      icono = Icons.report_problem_outlined;
      color = AppColors.warning;
    } else if (movimiento.motivo == 'Caducado') {
      icono = Icons.event_busy;
      color = AppColors.error;
    }

    return TarjetaItem(
      icono: icono,
      colorIcono: color,
      titulo: movimiento.producto,
      subtitulo: '${movimiento.motivo}\n${movimiento.fecha}',
      derecha: Text(
        '-${movimiento.cantidad}',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}
