import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.local_cafe_rounded,
              size: 64,
              color: AppColors.cafeGold,
            ),
            const SizedBox(height: 16),
            Text(
              'Purísimo Café',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            const Text('Estructura base del proyecto lista.'),
          ],
        ),
      ),
    );
  }
}
