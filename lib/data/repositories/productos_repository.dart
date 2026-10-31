import '../../core/constants/api_constants.dart';
import '../../core/errors/app_exception.dart';
import '../../core/network/api_client.dart';
import '../models/producto.dart';

class ProductosRepository {
  final ApiClient client;

  ProductosRepository(this.client);

  // Pide el inventario (nombre, categoría, precio y stock)
  Future<List<Producto>> listarInventario() async {
    final json = await client.get(ApiConstants.inventario);

    if (json is! List) {
      throw AppException('La respuesta del servidor no es válida.');
    }

    return json
        .map((e) => Producto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // Pide las descripciones de los productos
  Future<Map<int, String>> listarDescripciones() async {
    final json = await client.get(ApiConstants.productos);

    if (json is! List) {
      throw AppException('La respuesta del servidor no es válida.');
    }

    Map<int, String> descripciones = {};
    for (var item in json) {
      int id = item['productoID'] ?? 0;
      descripciones[id] = item['descripcion'] ?? '';
    }
    return descripciones;
  }
}
