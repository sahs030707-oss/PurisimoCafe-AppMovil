import '../../core/constants/api_constants.dart';
import '../../core/errors/app_exception.dart';
import '../../core/network/api_client.dart';
import '../models/transaccion.dart';

class ComprasRepository {
  final ApiClient client;

  ComprasRepository(this.client);

  // Pide todas las compras
  Future<List<Transaccion>> listarAsync() async {
    final json = await client.get(ApiConstants.compras);

    if (json is! List) {
      throw AppException('La respuesta del servidor no es válida.');
    }

    return json
        .map((e) => Transaccion.fromCompraJson(e as Map<String, dynamic>))
        .toList();
  }
}
