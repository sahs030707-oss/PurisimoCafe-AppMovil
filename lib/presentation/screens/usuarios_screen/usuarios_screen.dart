import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/usuario.dart';
import '../../providers/usuario_provider.dart';
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

  // Se ejecuta una vez, cuando se abre la pantalla
  @override
  void initState() {
    super.initState();
    final provider = context.read<UsuarioProvider>();
    Future.microtask(() {
      provider.cargar();
    });
  }

  // Devuelve los usuarios que coinciden con la búsqueda y el rol elegido
  List<Usuario> _filtrar(List<Usuario> todos) {
    List<Usuario> resultado = [];
    for (Usuario u in todos) {
      bool coincide = u.nombre.toLowerCase().contains(_busqueda.toLowerCase());
      bool rolOk = _rol == 'Todos' || u.rol == _rol;
      if (coincide && rolOk) {
        resultado.add(u);
      }
    }
    return resultado;
  }

  // Cambia el estado de un usuario y avisa si hubo un problema
  void _cambiarEstado(UsuarioProvider provider, Usuario u, bool valor) async {
    String mensaje = await provider.cambiarEstado(u, valor);

    if (!mounted) return;

    if (mensaje != '') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensaje)),
      );
    }
  }

  // Decide qué mostrar: cargando, error, vacío o la lista
  Widget _contenido(UsuarioProvider provider, List<Usuario> lista) {
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
      return const Center(child: Text('No se encontraron usuarios'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: lista.length,
      itemBuilder: (context, i) {
        Usuario u = lista[i];
        return TarjetaUsuario(
          usuario: u,
          onCambiarActivo: (valor) {
            _cambiarEstado(provider, u, valor);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UsuarioProvider>();
    List<Usuario> lista = _filtrar(provider.usuarios);

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
          Expanded(child: _contenido(provider, lista)),
        ],
      ),
    );
  }
}
