import '../../core/constants/api_constants.dart';
import '../../core/errors/app_exception.dart';
import '../../core/network/api_client.dart';
import '../models/transaccion.dart';

class VentasRepository {
  final ApiClient client;

  VentasRepository(this.client);

  // Pide todas las ventas
  Future<List<Transaccion>> listarAsync() async {
    final json = await client.get(ApiConstants.ventas);

    if (json is! List) {
      throw AppException('La respuesta del servidor no es válida.');
    }

    return json
        .map((e) => Transaccion.fromVentaJson(e as Map<String, dynamic>))
        .toList();
  }
}
