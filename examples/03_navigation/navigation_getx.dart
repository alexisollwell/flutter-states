import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavGetXHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nav con GetX')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navegación con GetX - ¡Sin context!
            Get.to(() => NavGetXDetail());
          },
          child: const Text('Ir a Detalles'),
        ),
      ),
    );
  }
}

class NavGetXDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalles')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Volver atrás con GetX
            Get.back();
          },
          child: const Text('Volver'),
        ),
      ),
    );
  }
}
