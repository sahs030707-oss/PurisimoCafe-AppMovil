import 'package:flutter/material.dart';
import '../../core/errors/app_exception.dart';
import '../../data/models/usuario.dart';
import '../../services/usuario_service.dart';

class UsuarioProvider extends ChangeNotifier {
  final UsuarioService service;

  UsuarioProvider(this.service);

  List<Usuario> usuarios = [];
  bool cargando = false;
  String error = '';

  // Pide los usuarios a la API
  Future<void> cargar() async {
    cargando = true;
    error = '';
    notifyListeners();

    try {
      usuarios = await service.obtenerUsuarios();
    } on AppException catch (e) {
      error = e.mensaje;
    } catch (e) {
      error = 'Ocurrió un error inesperado';
    }

    cargando = false;
    notifyListeners();
  }

  // Activa o desactiva un usuario.
  // Devuelve '' si todo salió bien, o el mensaje del error.
  Future<String> cambiarEstado(Usuario usuario, bool activo) async {
    try {
      await service.cambiarEstado(usuario, activo);
      usuario.activo = activo;
      notifyListeners();
      return '';
    } on AppException catch (e) {
      return e.mensaje;
    } catch (e) {
      return 'Ocurrió un error inesperado';
    }
  }
}
