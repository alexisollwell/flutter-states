import 'package:get/get.dart';

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
