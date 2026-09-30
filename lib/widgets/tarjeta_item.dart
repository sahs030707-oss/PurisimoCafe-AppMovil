import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

// Tarjeta con icono, título y subtítulo. La usan varias pantallas
class TarjetaItem extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String subtitulo;
  final Widget? extra; // algo opcional debajo del subtítulo
  final Widget? derecha; // algo opcional a la derecha
  final Color colorIcono;

  const TarjetaItem({
    super.key,
    required this.icono,
    required this.titulo,
    required this.subtitulo,
    this.extra,
    this.derecha,
    this.colorIcono = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> textos = [
      Text(subtitulo,
          style: const TextStyle(fontSize: 12, color: AppColors.gray700)),
    ];
    if (extra != null) {
      textos.add(const SizedBox(height: 4));
      textos.add(extra!);
    }

    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: colorIcono.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icono, color: colorIcono),
        ),
        title: Text(
          titulo,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.gray900),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: textos,
        ),
        trailing: derecha,
      ),
    );
  }
}
