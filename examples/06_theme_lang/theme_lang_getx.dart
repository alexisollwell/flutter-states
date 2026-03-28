import 'package:flutter/material.dart';
import 'package:get/get.dart';

// GetX permite definir diccionarios sin librerias.
class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello World!',
          'change_theme': 'Change Theme',
          'change_lang': 'Change to Spanish',
        },
        'es_MX': {
          'hello': 'Hola Mundo!',
          'change_theme': 'Cambiar Tema',
          'change_lang': 'Cambiar a Ingles',
        }
      };
}

class ThemeLangGetXView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tema e Idioma: GetX'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Traduccion directa al vuelo agregando .tr a cualquier texto clave
            Text('hello'.tr, style: TextStyle(fontSize: 24)),
            
            SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: () {
                // Cambio de modo claro/oscuro en 1 linea y sin importar donde estes
                Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
              },
              child: Text('change_theme'.tr),
            ),
            
            SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: () {
                // Cambio de idioma al vuelo
                if (Get.locale?.languageCode == 'es') {
                  Get.updateLocale(Locale('en', 'US'));
                } else {
                  Get.updateLocale(Locale('es', 'MX'));
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
