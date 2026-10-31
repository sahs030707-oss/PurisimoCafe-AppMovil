import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/producto.dart';
import '../../providers/producto_provider.dart';
import '../../widgets/encabezado_filtros.dart';
import 'widgets/producto_inventario_card.dart';

class InventarioScreen extends StatefulWidget {
  const InventarioScreen({super.key});

  @override
  State<InventarioScreen> createState() => _InventarioScreenState();
}

class _InventarioScreenState extends State<InventarioScreen> {
  String _busqueda = '';
  String _filtro = 'Todos';

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

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: lista.length,
      itemBuilder: (context, i) {
        return ProductoInventarioCard(producto: lista[i]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductoProvider>();
    List<Producto> lista = _filtrar(provider.productos);

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
              'Cafes Calientes',
              'Cafes Frios',
              'Bebidas Naturales',
              'Postres',
              'Comidas Rapidas',
              'Reposteria',
              'Desayunos'
            ],
            seleccionada: _filtro,
            onFiltro: (op) {
              setState(() {
                _filtro = op;
              });
            },
          ),
          Expanded(child: _contenido(provider, lista)),
        ],
      ),
    );
  }
}
