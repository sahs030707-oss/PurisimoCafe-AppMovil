import 'package:flutter/material.dart';
import '../../data/repositories/tema_repository.dart';

class TemaProvider extends ChangeNotifier {
  final TemaRepository repository;

  TemaProvider(this.repository);

  bool modoOscuro = false;

  // Lee la preferencia guardada (se usa al abrir la app)
  Future<void> cargar() async {
    try {
      modoOscuro = await repository.leerModoOscuro();
    } catch (e) {
      modoOscuro = false;
    }
    notifyListeners();
  }

  // Activa o desactiva el modo oscuro y lo guarda
  Future<void> cambiar(bool valor) async {
    modoOscuro = valor;
    notifyListeners();
    await repository.guardarModoOscuro(valor);
  }
}
