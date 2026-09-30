import 'package:flutter/material.dart';
import '../../data/datos_simulados.dart';
import '../../models/producto.dart';
import '../../widgets/dialogo_confirmar.dart';
import '../../widgets/encabezado_filtros.dart';
import 'widgets/producto_inventario_card.dart';

class InventarioScreen extends StatefulWidget {
  const InventarioScreen({super.key});

  @override
  State<InventarioScreen> createState() => _InventarioScreenState();
}

class _InventarioScreenState extends State<InventarioScreen> {
  final List<Producto> _lista = List.from(productos); // copia de los productos
  String _busqueda = '';
  String _filtro = 'Todos';

  // Devuelve los productos que coinciden con la búsqueda y el filtro
  List<Producto> _filtrar() {
    List<Producto> resultado = [];
    for (Producto p in _lista) {
      bool coincide = p.nombre.toLowerCase().contains(_busqueda.toLowerCase());
      bool filtroOk = false;
      if (_filtro == 'Todos') {
        filtroOk = true;
      } else if (_filtro == 'Bajo Stock') {
        filtroOk = p.stock <= 5;
      } else {
        filtroOk = p.categoria == _filtro;
      }
      if (coincide && filtroOk) {
        resultado.add(p);
      }
    }
    return resultado;
  }

  void _eliminar(Producto p) async {
    bool si = await confirmar(
        context, '¿Deseas eliminar ${p.nombre} del inventario?');
    if (si) {
      setState(() {
        _lista.remove(p);
      });
    }
  }

  void _editarStock(Producto p) async {
    TextEditingController controller =
        TextEditingController(text: p.stock.toString());
    int? nuevo = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Stock de ${p.nombre}'),
        content: TextField(
            controller: controller, keyboardType: TextInputType.number),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(context, int.tryParse(controller.text)),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
    if (nuevo != null) {
      setState(() {
        p.stock = nuevo;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Producto> lista = _filtrar();

    return Scaffold(
      appBar: AppBar(title: const Text('Inventario')),
      body: Column(
        children: [
          EncabezadoFiltros(
            hint: 'Buscar productos',
            onBuscar: (texto) {
              setState(() {
                _busqueda = texto;
              });
            },
            opciones: const [
              'Todos',
              'Bajo Stock',
              'Bebida Fría',
              'Caliente',
              'Insumo'
            ],
            seleccionada: _filtro,
            onFiltro: (op) {
              setState(() {
                _filtro = op;
              });
            },
          ),
          Expanded(
            child: lista.isEmpty
                ? const Center(child: Text('No se encontraron productos'))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: lista.length,
                    itemBuilder: (context, i) {
                      Producto p = lista[i];
                      return ProductoInventarioCard(
                        producto: p,
                        onEditar: () => _editarStock(p),
                        onEliminar: () => _eliminar(p),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
