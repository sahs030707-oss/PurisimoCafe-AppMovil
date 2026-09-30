// Responsable: MABELIN (sube 4ta)
import 'package:flutter/material.dart';
import 'widgets/tarjeta_metricas.dart';

class MetricasUsuarioScreen extends StatefulWidget {
  const MetricasUsuarioScreen({super.key});

  @override
  State<MetricasUsuarioScreen> createState() => _MetricasUsuarioScreenState();
}

class _MetricasUsuarioScreenState extends State<MetricasUsuarioScreen> {
  String _abierto = 'Daniela'; // nombre del usuario que está desplegado

  // Datos de prueba de cada usuario (los 4 valores van en el mismo orden de los títulos)
  final List<Map<String, dynamic>> _usuarios = [
    {'nombre': 'Daniela', 'rol': 'Administrador', 'valores': ['18', '27', '12', 'C\$ 25,450']},
    {'nombre': 'Steven', 'rol': 'Administrador', 'valores': ['15', '30', '8', 'C\$ 18,200']},
    {'nombre': 'Mabelin', 'rol': 'Cajero', 'valores': ['187', 'C\$ 8,450', '214', '140 / 74']},
    {'nombre': 'Yaoska', 'rol': 'Cajero', 'valores': ['120', 'C\$ 5,300', '150', '90 / 60']},
  ];

  @override
  Widget build(BuildContext context) {
    // Creamos una tarjeta por cada usuario
    List<Widget> tarjetas = [];
    for (var u in _usuarios) {
      String nombre = u['nombre'];
      tarjetas.add(TarjetaMetricas(
        nombre: nombre,
        rol: u['rol'],
        valores: List<String>.from(u['valores']),
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

    return Scaffold(
      appBar: AppBar(title: const Text('Métricas de usuario')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Toca un usuario para ver sus métricas'),
          const SizedBox(height: 16),
          Column(children: tarjetas),
        ],
      ),
    );
  }
}
