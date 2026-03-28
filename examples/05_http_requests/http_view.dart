import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'http_controller.dart';

class HttpGetXView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpGetXController controller = Get.put(HttpGetXController());

    return Scaffold(
      appBar: AppBar(title: const Text('Peticiones HTTP: GetConnect')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.users.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(controller.users[index]['name']),
              subtitle: Text(controller.users[index]['email']),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.getUsers,
        child: const Icon(Icons.download),
      ),
    );
  }
}
