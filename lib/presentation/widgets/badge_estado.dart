import 'package:flutter/material.dart';

// Etiqueta pequeña de color (ej: "Agotado", "Cajero")
class BadgeEstado extends StatelessWidget {
  final String texto;
  final Color color;

  const BadgeEstado({super.key, required this.texto, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        texto,
        style:
            TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}
