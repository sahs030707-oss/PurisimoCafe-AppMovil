import 'package:flutter/material.dart';
import '../../data/datos_simulados.dart';
import '../../models/transaccion.dart';
import '../../widgets/selector_segmentos.dart';
import 'widgets/tarjeta_transaccion.dart';

class HistorialScreen extends StatefulWidget {
  const HistorialScreen({super.key});

  @override
  State<HistorialScreen> createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {
  int _tab = 0; // 0 = ventas, 1 = compras

  @override
  Widget build(BuildContext context) {
    // Según la pestaña elegida mostramos ventas o compras
    List<Transaccion> lista;
    if (_tab == 0) {
      lista = ventas;
    } else {
      lista = compras;
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
            Expanded(
              child: ListView.builder(
                itemCount: lista.length,
                itemBuilder: (context, i) {
                  return TarjetaTransaccion(
                      transaccion: lista[i], esVenta: _tab == 0);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
