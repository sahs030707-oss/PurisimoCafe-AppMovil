import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

// Cuadro con un resumen (ej: Ventas, Compras, Ganancia)
class TarjetaResumen extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String valor;
  final Color color;

  const TarjetaResumen({
    super.key,
    required this.icono,
    required this.titulo,
    required this.valor,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icono, color: color),
            const SizedBox(height: 8),
            Text(titulo,
                style: const TextStyle(fontSize: 12, color: AppColors.gray700)),
            Text(
              valor,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gray900),
            ),
          ],
        ),
      ),
    );
  }
}
