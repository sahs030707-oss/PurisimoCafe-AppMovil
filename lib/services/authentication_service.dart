import '../core/errors/app_exception.dart';
import '../core/network/api_client.dart';
import '../data/models/sesion.dart';
import '../data/repositories/auth_repository.dart';

class AuthenticationService {
  final AuthRepository _repository;
  final ApiClient _client;
  Sesion? sesionActual;

  AuthenticationService(this._repository, this._client);

  // Inicia sesión y guarda el token
  Future<Sesion> iniciarSesion(String correo, String clave) async {
    if (correo.isEmpty || clave.isEmpty) {
      throw AppException('Completa todos los campos');
    }

    final sesion = await _repository.login(correo, clave);
    _client.token = sesion.token;
    sesionActual = sesion;
    return sesion;
  }

  // Cierra la sesión borrando el token
  void cerrarSesion() {
    _client.token = null;
    sesionActual = null;
  }
}
