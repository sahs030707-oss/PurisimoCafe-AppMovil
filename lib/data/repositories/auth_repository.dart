import '../../core/constants/api_constants.dart';
import '../../core/errors/app_exception.dart';
import '../../core/network/api_client.dart';
import '../models/sesion.dart';

class AuthRepository {
  final ApiClient client;

  AuthRepository(this.client);

  Future<Sesion> login(String correo, String clave) async {
    final json = await client.post(
      ApiConstants.login,
      body: {'correo': correo, 'clave': clave},
    );

    if (json is! Map<String, dynamic>) {
      throw AppException('La respuesta del servidor no es válida.');
    }

    return Sesion.fromJson(json);
  }
}
