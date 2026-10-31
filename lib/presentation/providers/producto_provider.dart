import 'package:flutter/material.dart';
import '../../core/errors/app_exception.dart';
import '../../data/models/producto.dart';
import '../../services/producto_service.dart';

class ProductoProvider extends ChangeNotifier {
  final ProductoService service;

  ProductoProvider(this.service);

  List<Producto> productos = [];
  bool cargando = false;
  String error = '';

  // Pide los productos a la API
  Future<void> cargar() async {
    cargando = true;
    error = '';
    notifyListeners();

    try {
      productos = await service.obtenerProductos();
    } on AppException catch (e) {
      error = e.mensaje;
    } catch (e) {
      error = 'Ocurrió un error inesperado';
    }

    cargando = false;
    notifyListeners();
  }
}
