import 'package:get/get.dart';

// Este Provider puede vivir separado ya que unicamente se encarga de conectar 
// a recursos de red utilizando GetConnect integrado de GetX.
class UserProvider extends GetConnect {
  Future<List<dynamic>> fetchUsers() async {
    final response = await get('https://jsonplaceholder.typicode.com/users');
    
    if (response.status.hasError) {
      return Future.error(response.statusText ?? 'Error de conexion');
    } else {
      return response.body; 
    }
  }
}
