import 'package:get/get.dart';
import 'user_provider.dart';

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
      Get.snackbar('Atencion', 'No se descargo la informacion');
    } finally {
      isLoading.value = false;
    }
  }
}
