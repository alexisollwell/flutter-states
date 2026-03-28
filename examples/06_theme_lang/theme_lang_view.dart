import 'package:flutter/material.dart';
import 'package:get/get.dart';
// En una app real, importas messages.dart en tu configuracion del GetMaterialApp.

class ThemeLangGetXView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tema e Idioma: GetX'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('hello'.tr, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
              },
              child: Text('change_theme'.tr),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (Get.locale?.languageCode == 'es') {
                  Get.updateLocale(const Locale('en', 'US'));
                } else {
                  Get.updateLocale(const Locale('es', 'MX'));
                }
              },
              child: Text('change_lang'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
