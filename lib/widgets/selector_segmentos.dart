// Responsable: MABELIN (sube 4ta)
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

// Selector de dos o más pestañas (ej: Ventas | Compras)
class SelectorSegmentos extends StatelessWidget {
  final List<String> opciones;
  final int seleccionado;
  final ValueChanged<int> onChanged;

  const SelectorSegmentos({
    super.key,
    required this.opciones,
    required this.seleccionado,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> botones = [];
    for (int i = 0; i < opciones.length; i++) {
      bool activo = i == seleccionado;
      botones.add(Expanded(
        child: GestureDetector(
          onTap: () => onChanged(i),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: activo ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              opciones[i],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: activo ? Colors.white : AppColors.gray700,
              ),
            ),
          ),
        ),
      ));
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.gray200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(children: botones),
    );
  }
}
