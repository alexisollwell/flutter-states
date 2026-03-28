import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Definimos un Provider o servicio conectando a GetConnect
class UserProvider extends GetConnect {
  Future<List<dynamic>> fetchUsers() async {
    // Ya incluye HTTP integrado
    final response = await get('https://jsonplaceholder.typicode.com/users');
    
    if (response.status.hasError) {
      return Future.error(response.statusText ?? 'Error al conectar');
    } else {
      // body ya viene como coleccion Dart parseada
      return response.body; 
    }
  }
}

class HttpGetXController extends GetxController {
  final UserProvider _provider = UserProvider();
  
  var users = [].obs;
  var isLoading = false.obs;

  void getUsers() async {
    isLoading.value = true;
    try {
      var data = await _provider.fetchUsers();
      users.assignAll(data);
    } catch (e) {
      Get.snackbar('Error', 'No se pudo obtener informacion');
    } finally {
      isLoading.value = false;
    }
  }
}

class HttpGetXView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpGetXController controller = Get.put(HttpGetXController());

    return Scaffold(
      appBar: AppBar(title: Text('Peticiones HTTP: GetConnect')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
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
        child: Icon(Icons.download),
      ),
    );
  }
}
