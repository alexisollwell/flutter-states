import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'counter_controller.dart';

class CounterGetXView extends StatelessWidget {
  const CounterGetXView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Instanciamos el controlador separado
    final CounterController c = Get.put(CounterController());

    return Scaffold(
      appBar: AppBar(title: const Text('Counter con GetX')),
      body: Center(
        child: Obx(() => Text('Contador: ${c.count}', style: const TextStyle(fontSize: 24))),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: c.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
