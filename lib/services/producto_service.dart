import '../data/models/producto.dart';
import '../data/repositories/productos_repository.dart';

class ProductoService {
  final ProductosRepository _repository;

  ProductoService(this._repository);

  // Devuelve los productos activos con su descripción
  Future<List<Producto>> obtenerProductos() async {
    List<Producto> inventario = await _repository.listarInventario();
    Map<int, String> descripciones = await _repository.listarDescripciones();

    List<Producto> resultado = [];
    for (Producto p in inventario) {
      // Solo mostramos los productos activos
      if (p.estado) {
        p.descripcion = descripciones[p.id] ?? '';
        resultado.add(p);
      }
    }
    return resultado;
  }
}
