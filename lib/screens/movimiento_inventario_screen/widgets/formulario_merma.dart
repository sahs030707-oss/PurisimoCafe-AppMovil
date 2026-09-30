import 'package:flutter/material.dart';
import '../../../data/datos_simulados.dart';
import '../../../models/movimiento.dart';
import '../../../models/producto.dart';
import '../../../widgets/chips_filtro.dart';

// Ventanita para registrar una merma nueva
class FormularioMerma extends StatefulWidget {
  const FormularioMerma({super.key});

  @override
  State<FormularioMerma> createState() => _FormularioMermaState();
}

class _FormularioMermaState extends State<FormularioMerma> {
  final TextEditingController _cantidadController = TextEditingController();
  Producto? _producto;
  String _motivo = motivosMerma[0];

  // Fecha de hoy en formato dd/mm/aaaa
  String _fechaHoy() {
    DateTime hoy = DateTime.now();
    String dia = hoy.day.toString().padLeft(2, '0');
    String mes = hoy.month.toString().padLeft(2, '0');
    return '$dia/$mes/${hoy.year}';
  }

  void _guardar() {
    int cantidad = int.tryParse(_cantidadController.text) ?? 0;
    // Solo guarda si eligió producto y puso una cantidad válida
    if (_producto == null || cantidad <= 0) {
      return;
    }
    Movimiento nueva = Movimiento(
      producto: _producto!.nombre,
      cantidad: cantidad,
      motivo: _motivo,
      fecha: _fechaHoy(),
    );
    Navigator.pop(context, nueva);
  }

  @override
  Widget build(BuildContext context) {
    // Lista de productos para el menú desplegable
    List<DropdownMenuItem<Producto>> items = [];
    for (Producto p in productos) {
      items.add(DropdownMenuItem(value: p, child: Text(p.nombre)));
    }

    return AlertDialog(
      title: const Text('Registrar merma'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<Producto>(
            initialValue: _producto,
            hint: const Text('Selecciona un producto'),
            items: items,
            onChanged: (p) {
              setState(() {
                _producto = p;
              });
            },
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _cantidadController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Cantidad'),
          ),
          const SizedBox(height: 16),
          ChipsFiltro(
            opciones: motivosMerma,
            seleccionada: _motivo,
            onChanged: (m) {
              setState(() {
                _motivo = m;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: _guardar,
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
