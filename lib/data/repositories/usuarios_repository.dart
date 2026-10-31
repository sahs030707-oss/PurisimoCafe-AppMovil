import '../../core/constants/api_constants.dart';
import '../../core/errors/app_exception.dart';
import '../../core/network/api_client.dart';
import '../models/usuario.dart';

class UsuariosRepository {
  final ApiClient client;

  UsuariosRepository(this.client);

  // Pide todos los usuarios (activos e inactivos)
  Future<List<Usuario>> listarAsync() async {
    final json = await client.get('${ApiConstants.usuarios}/Todos');

    if (json is! List) {
      throw AppException('La respuesta del servidor no es válida.');
    }

    return json
        .map((e) => Usuario.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // Activa o desactiva un usuario
  Future<void> cambiarEstado(int id, bool activo) async {
    await client.put(
      '${ApiConstants.usuarios}/$id/Estado',
      query: {'activo': activo.toString()},
    );
  }
}
