import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/movimiento.dart';
import '../../../../data/models/producto.dart';
import '../../../providers/producto_provider.dart';
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
  String _mensaje = '';

  void _guardar() {
    int cantidad = int.tryParse(_cantidadController.text) ?? 0;

    // Revisamos los datos antes de guardar
    if (_producto == null) {
      setState(() {
        _mensaje = 'Selecciona un producto';
      });
      return;
    }
    if (cantidad <= 0) {
      setState(() {
        _mensaje = 'La cantidad debe ser mayor a 0';
      });
      return;
    }
    if (cantidad > _producto!.stock) {
      setState(() {
        _mensaje = 'Solo hay ${_producto!.stock} en stock';
      });
      return;
    }

    Movimiento nueva = Movimiento(
      productoId: _producto!.id,
      producto: _producto!.nombre,
      cantidad: cantidad,
      motivo: _motivo,
      fecha: '',
    );
    Navigator.pop(context, nueva);
  }

  @override
  Widget build(BuildContext context) {
    // Productos que ya cargó la app desde la API
    List<Producto> productos = context.read<ProductoProvider>().productos;

    // Lista de productos para el menú desplegable
    List<DropdownMenuItem<Producto>> items = [];
    for (Producto p in productos) {
      items.add(DropdownMenuItem(
        value: p,
        child: Text('${p.nombre} (stock: ${p.stock})'),
      ));
    }

    return AlertDialog(
      title: const Text('Registrar merma'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<Producto>(
              isExpanded: true,
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
            if (_mensaje != '')
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  _mensaje,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
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
