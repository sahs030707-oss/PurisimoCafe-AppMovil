import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/di/injection.dart';
import '../../../data/models/usuario.dart';
import '../../../services/reporte_service.dart';
import '../../providers/historial_provider.dart';
import '../../providers/usuario_provider.dart';
import 'widgets/tarjeta_metricas.dart';

class MetricasUsuarioScreen extends StatefulWidget {
  const MetricasUsuarioScreen({super.key});

  @override
  State<MetricasUsuarioScreen> createState() => _MetricasUsuarioScreenState();
}

class _MetricasUsuarioScreenState extends State<MetricasUsuarioScreen> {
  final ReporteService _service = sl<ReporteService>();
  String _abierto = ''; // nombre del usuario que está desplegado

  // Se ejecuta una vez, cuando se abre la pantalla
  @override
  void initState() {
    super.initState();
    final usuarios = context.read<UsuarioProvider>();
    final historial = context.read<HistorialProvider>();
    Future.microtask(() {
      usuarios.cargar();
      historial.cargar();
    });
  }

  // Vuelve a pedir los datos a la API
  void _cargar() {
    context.read<UsuarioProvider>().cargar();
    context.read<HistorialProvider>().cargar();
  }

  // Crea una tarjeta por cada usuario
  Widget _lista(UsuarioProvider usuarios, HistorialProvider historial) {
    if (usuarios.usuarios.isEmpty) {
      return const Center(child: Text('No hay usuarios'));
    }

    List<Widget> tarjetas = [];
    for (Usuario u in usuarios.usuarios) {
      String nombre = u.nombre;
      tarjetas.add(TarjetaMetricas(
        nombre: nombre,
        rol: u.rol,
        valores:
            _service.metricasDeUsuario(u, historial.ventas, historial.compras),
        abierta: _abierto == nombre,
        onTap: () {
          setState(() {
            // Si ya estaba abierta la cerramos, si no la abrimos
            if (_abierto == nombre) {
              _abierto = '';
            } else {
              _abierto = nombre;
            }
          });
        },
      ));
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Toca un usuario para ver sus métricas'),
        const SizedBox(height: 16),
        Column(children: tarjetas),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final usuarios = context.watch<UsuarioProvider>();
    final historial = context.watch<HistorialProvider>();

    // Decide qué mostrar: cargando, error o la lista
    Widget cuerpo;
    if (usuarios.cargando || historial.cargando) {
      cuerpo = const Center(child: CircularProgressIndicator());
    } else if (usuarios.error != '' || historial.error != '') {
      String mensaje = usuarios.error;
      if (mensaje == '') {
        mensaje = historial.error;
      }
      cuerpo = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(mensaje, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _cargar,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    } else {
      cuerpo = _lista(usuarios, historial);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Métricas de usuario')),
      body: cuerpo,
    );
  }
}
