// Responsable: MABELIN (sube 4ta)
// Este archivo es el que faltaba y causaba el error "BarraBusqueda isn't defined"
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

// Caja de texto para buscar
class BarraBusqueda extends StatelessWidget {
  final String hint;
  final ValueChanged<String> onChanged;

  const BarraBusqueda({super.key, required this.hint, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: AppColors.gray200.withValues(alpha: 0.5),
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
