import '../../core/constants/api_constants.dart';
import '../../core/errors/app_exception.dart';
import '../../core/network/api_client.dart';
import '../models/movimiento.dart';

class MovimientosRepository {
  final ApiClient client;

  MovimientosRepository(this.client);

  // Pide todas las mermas
  Future<List<Movimiento>> listarAsync() async {
    final json = await client.get(ApiConstants.movimientos);

    if (json is! List) {
      throw AppException('La respuesta del servidor no es válida.');
    }

    return json
        .map((e) => Movimiento.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // Envía una merma nueva a la API
  Future<void> registrarAsync(Movimiento movimiento) async {
    await client.post(ApiConstants.movimientos, body: movimiento.toJson());
  }
}
