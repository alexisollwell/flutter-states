import 'package:get/get.dart';

class ApiController extends GetxController {
  var items = <String>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData(); 
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    
    // Simulamos llamada a servidor
    await Future.delayed(const Duration(seconds: 2));
    
    items.assignAll(['Elemento 1', 'Elemento 2', 'Elemento 3']);
    isLoading.value = false;
  }
}
