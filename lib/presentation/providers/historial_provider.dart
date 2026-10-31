import 'package:flutter/material.dart';
import '../../core/errors/app_exception.dart';
import '../../data/models/transaccion.dart';
import '../../services/historial_service.dart';

class HistorialProvider extends ChangeNotifier {
  final HistorialService service;

  HistorialProvider(this.service);

  List<Transaccion> ventas = [];
  List<Transaccion> compras = [];
  bool cargando = false;
  String error = '';

  // Pide las ventas y las compras a la API
  Future<void> cargar() async {
    cargando = true;
    error = '';
    notifyListeners();

    try {
      ventas = await service.obtenerVentas();
      compras = await service.obtenerCompras();
    } on AppException catch (e) {
      error = e.mensaje;
    } catch (e) {
      error = 'Ocurrió un error inesperado';
    }

    cargando = false;
    notifyListeners();
  }
}
