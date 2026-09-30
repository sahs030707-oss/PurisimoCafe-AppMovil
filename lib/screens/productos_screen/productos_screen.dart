import 'package:flutter/material.dart';
import '../../data/datos_simulados.dart';
import '../../models/producto.dart';
import '../../utils/formato.dart';
import '../../widgets/encabezado_filtros.dart';
import 'widgets/product_card.dart';

class ProductosScreen extends StatefulWidget {
  const ProductosScreen({super.key});

  @override
  State<ProductosScreen> createState() => _ProductosScreenState();
}

class _ProductosScreenState extends State<ProductosScreen> {
  String _busqueda = '';
  String _categoria = 'Todos';

  // Devuelve los productos que coinciden con la búsqueda y el filtro
  List<Producto> _filtrar() {
    List<Producto> resultado = [];
    for (Producto p in productos) {
      bool coincide = p.nombre.toLowerCase().contains(_busqueda.toLowerCase());
      bool categoriaOk = _categoria == 'Todos' || p.categoria == _categoria;
      // Los insumos no se venden, por eso no se muestran en el catálogo
      if (p.categoria != 'Insumo' && coincide && categoriaOk) {
        resultado.add(p);
      }
    }
    return resultado;
  }

  void _mostrarDetalle(Producto p) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(p.nombre),
        content: Text(
          'Categoría: ${p.categoria}\n'
          'Precio: ${cordobas(p.precio)}\n'
          '${p.disponible ? 'Disponible' : 'Agotado'}\n\n'
          '${p.descripcion}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Producto> lista = _filtrar();

    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo')),
      body: Column(
        children: [
          EncabezadoFiltros(
            hint: 'Buscar café...',
            onBuscar: (texto) {
              setState(() {
                _busqueda = texto;
              });
            },
            opciones: const ['Todos', 'Bebida Fría', 'Caliente'],
            seleccionada: _categoria,
            onFiltro: (op) {
              setState(() {
                _categoria = op;
              });
            },
          ),
          Expanded(
            child: lista.isEmpty
                ? const Center(child: Text('No se encontraron productos'))
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.9,
                    ),
                    itemCount: lista.length,
                    itemBuilder: (context, i) {
                      return ProductCard(
                        product: lista[i],
                        onTap: () => _mostrarDetalle(lista[i]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
