import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UtilsGetX extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Utils con GetX')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Snackbar con GetX - Código mínimo y sin context
                Get.snackbar('Hola', 'Soy un SnackBar de GetX',
                    snackPosition: SnackPosition.BOTTOM);
              },
              child: const Text('Mostrar SnackBar'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Dialog con GetX - Sin context
                Get.defaultDialog(
                  title: 'Alerta',
                  middleText: 'Este es un dialog de GetX',
                  textConfirm: 'Cerrar',
                  onConfirm: () => Get.back(),
                );
              },
              child: const Text('Mostrar Dialog'),
            ),
          ],
        ),
      ),
    );
  }
}
