import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/movimiento.dart';
import '../../providers/movimiento_provider.dart';
import '../../providers/producto_provider.dart';
import '../../widgets/encabezado_filtros.dart';
import 'widgets/formulario_merma.dart';
import 'widgets/tarjeta_movimiento.dart';

class MovimientoInventarioScreen extends StatefulWidget {
  const MovimientoInventarioScreen({super.key});

  @override
  State<MovimientoInventarioScreen> createState() =>
      _MovimientoInventarioScreenState();
}

class _MovimientoInventarioScreenState
    extends State<MovimientoInventarioScreen> {
  String _busqueda = '';
  String _filtro = 'Todos';

  // Se ejecuta una vez, cuando se abre la pantalla
  @override
  void initState() {
    super.initState();
    final movimientoProvider = context.read<MovimientoProvider>();
    final productoProvider = context.read<ProductoProvider>();
    Future.microtask(() {
      movimientoProvider.cargar();
      productoProvider.cargar(); // los productos se usan en el formulario
    });
  }

  // Devuelve las mermas que coinciden con la búsqueda y el motivo
  List<Movimiento> _filtrar(List<Movimiento> todas) {
    List<Movimiento> resultado = [];
    for (Movimiento m in todas) {
      bool coincide =
          m.producto.toLowerCase().contains(_busqueda.toLowerCase());
      bool motivoOk = _filtro == 'Todos' || m.motivo == _filtro;
      if (coincide && motivoOk) {
        resultado.add(m);
      }
    }
    return resultado;
  }

  // Abre el formulario y registra la merma en la API
  void _registrar() async {
    final movimientoProvider = context.read<MovimientoProvider>();
    final productoProvider = context.read<ProductoProvider>();

    Movimiento? nueva = await showDialog<Movimiento>(
      context: context,
      builder: (context) => const FormularioMerma(),
    );

    // Si el usuario canceló, no hacemos nada
    if (nueva == null) return;

    String mensaje = await movimientoProvider.registrar(nueva);

    if (!mounted) return;

    String texto = 'Merma registrada correctamente';
    if (mensaje != '') {
      texto = mensaje;
    } else {
      // El stock cambió, así que actualizamos los productos
      productoProvider.cargar();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(texto)),
    );
  }

  // Decide qué mostrar: cargando, error, vacío o la lista
  Widget _contenido(MovimientoProvider provider, List<Movimiento> lista) {
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
      return const Center(child: Text('No hay mermas registradas'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: lista.length,
      itemBuilder: (context, i) {
        return TarjetaMovimiento(movimiento: lista[i]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovimientoProvider>();
    List<Movimiento> lista = _filtrar(provider.movimientos);

    // Opciones del filtro: "Todos" + los motivos de merma
    List<String> opciones = ['Todos'];
    opciones.addAll(motivosMerma);

    return Scaffold(
      appBar: AppBar(title: const Text('Mermas de inventario')),
      body: Column(
        children: [
          EncabezadoFiltros(
            hint: 'Buscar producto',
            onBuscar: (texto) {
              setState(() {
                _busqueda = texto;
              });
            },
            opciones: opciones,
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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        onPressed: _registrar,
        icon: const Icon(Icons.add),
        label: const Text('Registrar merma'),
      ),
    );
  }
}
