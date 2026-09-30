// Responsable: MABELIN (sube 4ta)
import 'package:flutter/material.dart';
import 'barra_busqueda.dart';
import 'chips_filtro.dart';

// Parte de arriba de varias pantallas: barra de búsqueda + filtros
class EncabezadoFiltros extends StatelessWidget {
  final String hint;
  final ValueChanged<String> onBuscar;
  final List<String> opciones;
  final String seleccionada;
  final ValueChanged<String> onFiltro;

  const EncabezadoFiltros({
    super.key,
    required this.hint,
    required this.onBuscar,
    required this.opciones,
    required this.seleccionada,
    required this.onFiltro,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          BarraBusqueda(hint: hint, onChanged: onBuscar),
          const SizedBox(height: 12),
          ChipsFiltro(
            opciones: opciones,
            seleccionada: seleccionada,
            onChanged: onFiltro,
          ),
        ],
      ),
    );
  }
}
