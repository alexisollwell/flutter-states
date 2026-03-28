import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'api_controller.dart';

class ApiListGetXView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Se importa la instancia del controllador desde el archivo externo
    final ApiController apiController = Get.put(ApiController());

    return Scaffold(
      appBar: AppBar(title: const Text('API List con GetX')),
      body: Obx(() {
        if (apiController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: apiController.items.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text(apiController.items[index]));
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: apiController.fetchData,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
