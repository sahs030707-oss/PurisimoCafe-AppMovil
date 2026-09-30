// Responsable: MABELIN (sube 4ta)
import 'package:flutter/material.dart';

// Campo de texto con título pequeño arriba (ej: "Nombre de usuario")
class CampoPreferencia extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool oscuro; // true = modo oscuro activado

  const CampoPreferencia({
    super.key,
    required this.label,
    required this.controller,
    required this.oscuro,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: oscuro ? const Color(0xFF2A2A2A) : Colors.white,
        border: Border.all(color: oscuro ? Colors.white24 : Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 11, color: oscuro ? Colors.grey.shade400 : Colors.grey)),
          TextField(
            controller: controller,
            style: TextStyle(color: oscuro ? Colors.white : Colors.black87),
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
