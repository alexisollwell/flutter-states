import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterController extends GetxController {
  var count = 0.obs; // Variable reactiva
  void increment() => count++;
}

class CounterGetX extends StatelessWidget { // ¡No necesitamos StatefulWidget!
  const CounterGetX({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Instanciamos el controlador
    final CounterController c = Get.put(CounterController());

    return Scaffold(
      appBar: AppBar(title: const Text('Counter con GetX')),
      body: Center(
        // Obx reacciona a los cambios en variables .obs
        child: Obx(() => Text('Contador: ${c.count}', style: const TextStyle(fontSize: 24))),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: c.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
