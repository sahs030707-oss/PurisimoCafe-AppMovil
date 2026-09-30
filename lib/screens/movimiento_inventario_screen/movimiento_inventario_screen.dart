import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/datos_simulados.dart';
import '../../models/movimiento.dart';
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
  final List<Movimiento> _lista = List.from(movimientos); // copia de las mermas
  String _busqueda = '';
  String _filtro = 'Todos';

  // Devuelve las mermas que coinciden con la búsqueda y el motivo
  List<Movimiento> _filtrar() {
    List<Movimiento> resultado = [];
    for (Movimiento m in _lista) {
      bool coincide =
          m.producto.toLowerCase().contains(_busqueda.toLowerCase());
      bool motivoOk = _filtro == 'Todos' || m.motivo == _filtro;
      if (coincide && motivoOk) {
        resultado.add(m);
      }
    }
    return resultado;
  }

  void _registrar() async {
    Movimiento? nueva = await showDialog<Movimiento>(
      context: context,
      builder: (context) => const FormularioMerma(),
    );
    if (nueva != null) {
      setState(() {
        _lista.insert(0, nueva); // la ponemos de primera
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Movimiento> lista = _filtrar();

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
          Expanded(
            child: lista.isEmpty
                ? const Center(child: Text('No hay mermas registradas'))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: lista.length,
                    itemBuilder: (context, i) {
                      return TarjetaMovimiento(movimiento: lista[i]);
                    },
                  ),
          ),
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
