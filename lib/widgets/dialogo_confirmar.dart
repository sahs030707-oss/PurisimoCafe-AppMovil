import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

// Muestra una ventanita de "¿Estás seguro?". Devuelve true si el usuario confirma
Future<bool> confirmar(BuildContext context, String mensaje) async {
  bool? respuesta = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Confirmar acción'),
      content: Text(mensaje),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Confirmar', style: TextStyle(color: AppColors.error)),
        ),
      ],
    ),
  );
  return respuesta == true;
}
