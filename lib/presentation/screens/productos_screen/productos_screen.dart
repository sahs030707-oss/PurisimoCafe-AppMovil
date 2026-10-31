import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/formato.dart';
import '../../../data/models/producto.dart';
import '../../providers/producto_provider.dart';
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

  // Se ejecuta una vez, cuando se abre la pantalla
  @override
  void initState() {
    super.initState();
    final provider = context.read<ProductoProvider>();
    Future.microtask(() {
      provider.cargar();
    });
  }

  // Devuelve los productos que coinciden con la búsqueda y el filtro
  List<Producto> _filtrar(List<Producto> todos) {
    List<Producto> resultado = [];
    for (Producto p in todos) {
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

  // Decide qué mostrar: cargando, error, vacío o la lista
  Widget _contenido(ProductoProvider provider, List<Producto> lista) {
    if (provider.cargando) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != '') {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(provider.error, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                provider.cargar();
              },
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    if (lista.isEmpty) {
      return const Center(child: Text('No se encontraron productos'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductoProvider>();
    List<Producto> lista = _filtrar(provider.productos);

    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo')),
      body: Column(
        children: [
          EncabezadoFiltros(
            hint: 'Buscar Producto...',
            onBuscar: (texto) {
              setState(() {
                _busqueda = texto;
              });
            },
            opciones: const [
              'Todos',
              'Cafes Frios',
              'Cafes Calientes',
              'Bebidas Naturales',
              'Postres',
              'Comidas Rapidas',
              'Reposteria',
              'Desayunos'
            ],
            seleccionada: _categoria,
            onFiltro: (op) {
              setState(() {
                _categoria = op;
              });
            },
          ),
          Expanded(child: _contenido(provider, lista)),
        ],
      ),
    );
  }
}
