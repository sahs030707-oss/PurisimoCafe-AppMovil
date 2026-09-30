// Responsable: MABELIN (sube 4ta)
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

// Botones redondos para filtrar (ej: Todos, Caliente, Bebida Fría)
class ChipsFiltro extends StatelessWidget {
  final List<String> opciones;
  final String seleccionada;
  final ValueChanged<String> onChanged;

  const ChipsFiltro({
    super.key,
    required this.opciones,
    required this.seleccionada,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> chips = [];
    for (String op in opciones) {
      bool activo = op == seleccionada;
      chips.add(Padding(
        padding: const EdgeInsets.only(right: 8),
        child: ChoiceChip(
          label: Text(op),
          selected: activo,
          showCheckmark: false,
          selectedColor: AppColors.primary,
          labelStyle: TextStyle(color: activo ? Colors.white : AppColors.gray700),
          onSelected: (_) => onChanged(op),
        ),
      ));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: chips),
    );
  }
}
