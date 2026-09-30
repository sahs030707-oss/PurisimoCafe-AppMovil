import 'package:flutter/material.dart';
import '../../data/datos_simulados.dart';
import '../../models/usuario.dart';
import '../../widgets/encabezado_filtros.dart';
import 'widgets/tarjeta_usuario.dart';

class UsuariosScreen extends StatefulWidget {
  const UsuariosScreen({super.key});

  @override
  State<UsuariosScreen> createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  String _busqueda = '';
  String _rol = 'Todos';

  // Devuelve los usuarios que coinciden con la búsqueda y el rol elegido
  List<Usuario> _filtrar() {
    List<Usuario> resultado = [];
    for (Usuario u in usuarios) {
      bool coincide = u.nombre.toLowerCase().contains(_busqueda.toLowerCase());
      bool rolOk = _rol == 'Todos' || u.rol == _rol;
      if (coincide && rolOk) {
        resultado.add(u);
      }
    }
    return resultado;
  }

  @override
  Widget build(BuildContext context) {
    List<Usuario> lista = _filtrar();

    return Scaffold(
      appBar: AppBar(title: const Text('Usuarios')),
      body: Column(
        children: [
          EncabezadoFiltros(
            hint: 'Buscar usuario',
            onBuscar: (texto) {
              setState(() {
                _busqueda = texto;
              });
            },
            opciones: const ['Todos', 'Administrador', 'Cajero'],
            seleccionada: _rol,
            onFiltro: (op) {
              setState(() {
                _rol = op;
              });
            },
          ),
          Expanded(
            child: lista.isEmpty
                ? const Center(child: Text('No se encontraron usuarios'))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: lista.length,
                    itemBuilder: (context, i) {
                      Usuario u = lista[i];
                      return TarjetaUsuario(
                        usuario: u,
                        onCambiarActivo: (valor) {
                          setState(() {
                            u.activo = valor;
                          });
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
