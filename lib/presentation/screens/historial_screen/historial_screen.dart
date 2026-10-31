import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/transaccion.dart';
import '../../providers/historial_provider.dart';
import '../../widgets/selector_segmentos.dart';
import 'widgets/tarjeta_transaccion.dart';

class HistorialScreen extends StatefulWidget {
  const HistorialScreen({super.key});

  @override
  State<HistorialScreen> createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {
  int _tab = 0; // 0 = ventas, 1 = compras

  // Se ejecuta una vez, cuando se abre la pantalla
  @override
  void initState() {
    super.initState();
    final provider = context.read<HistorialProvider>();
    Future.microtask(() {
      provider.cargar();
    });
  }

  // Decide qué mostrar: cargando, error, vacío o la lista
  Widget _contenido(HistorialProvider provider, List<Transaccion> lista) {
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
      return const Center(child: Text('No hay registros todavía'));
    }

    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (context, i) {
        return TarjetaTransaccion(transaccion: lista[i], esVenta: _tab == 0);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HistorialProvider>();

    // Según la pestaña elegida mostramos ventas o compras
    List<Transaccion> lista;
    if (_tab == 0) {
      lista = provider.ventas;
    } else {
      lista = provider.compras;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Historial')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SelectorSegmentos(
              opciones: const ['Ventas', 'Compras'],
              seleccionado: _tab,
              onChanged: (i) {
                setState(() {
                  _tab = i;
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(child: _contenido(provider, lista)),
          ],
        ),
      ),
    );
  }
}
