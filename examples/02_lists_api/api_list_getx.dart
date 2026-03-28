import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApiController extends GetxController {
  var items = <String>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData(); // Llamada al iniciar
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    // Simulamos llamada a API
    await Future.delayed(const Duration(seconds: 2));
    items.assignAll(['Elemento 1', 'Elemento 2', 'Elemento 3']);
    isLoading.value = false;
  }
}

class ApiListGetX extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
