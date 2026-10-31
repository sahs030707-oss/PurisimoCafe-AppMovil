import '../core/errors/app_exception.dart';
import '../data/models/sesion.dart';
import '../data/models/usuario.dart';
import '../data/repositories/usuarios_repository.dart';
import 'authentication_service.dart';

class UsuarioService {
  final UsuariosRepository _repository;
  final AuthenticationService _auth;

  UsuarioService(this._repository, this._auth);

  Future<List<Usuario>> obtenerUsuarios() async {
    return await _repository.listarAsync();
  }

  Future<void> cambiarEstado(Usuario usuario, bool activo) async {
    Sesion? sesion = _auth.sesionActual;

    // Regla: nadie puede desactivarse a sí mismo
    if (!activo && sesion != null && sesion.usuarioId == usuario.id) {
      throw AppException('No puedes desactivar tu propio usuario.');
    }

    await _repository.cambiarEstado(usuario.id, activo);
  }
}
