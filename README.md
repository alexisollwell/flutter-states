# Flutter: setState() vs GetX

Bienvenido a la comparativa definitiva entre el manejo de estado tradicional en Flutter y el ecosistema GetX.

Esta pagina sirve como guia para entender por que y cuando transicionar de setState() a GetX, sus diferencias principales, y comparativas directas de codigo. Todos los ejemplos de codigo presentados aqui tambien estan disponibles como archivos individuales .dart en la carpeta /examples/ de este repositorio.

---

## 1. Instalacion y Configuracion Inicial

**Enlace oficial de la libreria:** [GetX en pub.dev](https://pub.dev/packages/get)

Para comenzar a utilizar GetX en tu proyecto, el proceso es muy sencillo pero requiere un pequeño ajuste en tu archivo principal.

### Paso 1: Agregar la dependencia
En la terminal de tu proyecto, ejecuta:
```bash
flutter pub add get
```

### Paso 2: Cambiar MaterialApp por GetMaterialApp
Para que GetX pueda manejar la navegacion, los dialogos y las utilidades generales sin requerir el Contexto de la aplicacion, necesitas envolver tu aplicacion en un `GetMaterialApp` dentro de tu archivo principal (`main.dart`).

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Reemplazamos MaterialApp por GetMaterialApp
      title: 'Comparativa GetX',
      home: const Home(), // Tu pantalla inicial
    );
  }
}
```

---

## 2. Por que GetX?

Flutter provee `setState()` como el metodo primario para actualizar la UI. Aunque es excelente para aplicaciones sencillas, en proyectos de mediana o gran escala suele generar problemas:
1. **Logica mezclada con la UI:** Acabas teniendo codigo muy acoplado, donde la vista, las validaciones y los llamados a servicios viven en un mismo archivo.
2. **Re-renderizado en cascada:** `setState()` redibuja todo el widget principal y sus sub-widgets dentro de un StatefulWidget. Esto consume recursos de procesamiento.
3. **Dependencia excesiva del Context (Context-hell):** Pasar la variable `context` profundamente hacia constructores o clases auxiliares para mostrar un dialogo o navegar puede concluir en errores si la pantalla ya se cerro al momento de usarla.

GetX resuelve estos inconvenientes:
- **Estado Reactivo Preciso:** En lugar de repintar pantallas, GetX usa escuchadores (`Obx`) que dibujan unicamente el widget exacto que sufrio un cambio (ej. solo el texto del precio).
- **Controladores Limpios:** Sacas toda tu logica y la aislas en Controladores puros, ignorando por completo la existencia de componentes de interfaz.
- **Acceso Global sin Context:** Navegar y lanzar dialogos y Snackbars ya no depende del `BuildContext`.

---

## 3. Comportamientos que NO requieren librerias extras en GetX

Una de las caracteristicas de GetX es incluir herramientas por las cuales, de manera tradicional, necesitarias recurrir pub.dev para instalar multiples paquetes.

### Peticiones HTTP (GetConnect vs paquetes de terceros)
Normalmente, si quieres conectar una API ocupas instalar `http` o `dio`. GetX incluye una clase nativa llamada **GetConnect** que hace peticiones rest de un modo aun mas sencillo y ya incorpora decodificacion JSON automatica.
*(Archivos en examples/05_http_requests)*

**Tradicional con paquete `http`:**
```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> obtenerUsuarios() async {
  final res = await http.get(Uri.parse('https://api.tu-servidor.com/users'));
  if (res.statusCode == 200) {
    final data = json.decode(res.body);
    // Asignar al estado...
  }
}
```

**Con GetX (Usando GetConnect, integrado sin instalar más nada):**
```dart
class UserProvider extends GetConnect {
  Future<void> obtenerUsuarios() async {
    final res = await get('https://api.tu-servidor.com/users');
    if (!res.status.hasError) { // El chequeo de errores es directo
      final data = res.body; // Ya viene decodificado, no ocupas "dart:convert"
      // Asignar al estado...
    }
  }
}
```

### Tema Claro / Oscuro
Para cambiar el tema de la aplicacion dinamicamente, de norma seria necesario instalar paquetes como `provider` o un estado en el componente raiz de la web.
*(Archivos en examples/06_theme_lang)*

**Con GetX (En una sola linea y desde cualquier controlador o vista):**
```dart
Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
```

### Internacionalizacion (Multi-Idioma)
Tradicionalmente necesitas agregar `flutter_localizations`, meter configuraciones extra en el MaterialApp de soporte local, y depender del context para cambiar y leer strings como `AppLocalizations.of(context)!.label`.
*(Archivos en examples/06_theme_lang)*

**Con GetX:**
Implementas una clase `Translations`, defines tus diccionarios en Mapas (`'es_MX': {'hi': 'Hola'}`), y llamas a su valor re-escribiendo los textos asi:
```dart
Text('hi'.tr);
```
Y para cambiar el idioma:
```dart
Get.updateLocale(Locale('es', 'MX'));
```

---

## 4. Comparativa: Gestion de Estado Simple y Variables

*Archivos en /examples/01_simple_state/*

### setState (Tradicional)
```dart
class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++; // Notifica el repintado de toda la clase _CounterState
    });
  }
}
```

### GetX
Las variables se convierten en reactivas anadiendo `.obs`. No requieres que la vista sea Stateful.
```dart
class CounterController extends GetxController {
  var count = 0.obs; 
  void increment() => count++; // Los componentes asociados usando Obx se actualizaran
}

// En tu vista separada...
Obx(() => Text('Contador: ${c.count}'));
```

---

## 5. Comparativa: Llamadas a APIs y Listas

*Archivos en /examples/02_lists_api/*

### setState (Tradicional)
Dependes del `initState` para llamar la carga. La vista administra internamente el listado y una booleana para mostrar cargadores.

```dart
bool _cargando = false;
List<String> _elementos = [];

Future<void> iniciarDescarga() async {
  setState(() => _cargando = true);
  // Llamada al servidor
  if(mounted) {
    setState(() {
      _elementos = ['A', 'B'];
      _cargando = false;
    });
  }
}
```

### GetX
Nuestra vista siempre dibuja a partir de las variables almacenadas remotamente en el controlador. Usamos el ciclo `onInit()` del `GetxController`.

```dart
class ApiController extends GetxController {
  var elementos = <String>[].obs;
  var cargando = false.obs;

  Future<void> iniciarDescarga() async {
    cargando.value = true;
    // Llamada al servidor
    elementos.assignAll(['A', 'B']); // Recarga la lista en la pantalla
    cargando.value = false;
  }
}
```

---

## 6. Comparativa: Navegacion

*Archivos en /examples/03_navigation/*

### setState (Tradicional)
```dart
// Avanzar de pagina
Navigator.push(context, MaterialPageRoute(builder: (context) => DetallesScreen()));
// Retroceder
Navigator.pop(context);
```

### GetX
```dart
// Avanzar de pagina
Get.to(() => DetallesScreen());
// Retroceder
Get.back();
```

---

## 7. Comparativa: Utilidades (Snackbars y Dialogos)

*Archivos en /examples/04_utilities/*

### setState (Tradicional)
Es necesario administrar el context asociado al nivel correcto del arbol.
```dart
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Mensaje')));

showDialog(
  context: context,
  builder: (context) => AlertDialog(title: Text('Aviso'), content: Text('Contenido')),
);
```

### GetX
Generados sin arboles de contexto, limpios y accesibles.
```dart
Get.snackbar('Titulo', 'Mensaje de texto');

Get.defaultDialog(
  title: 'Aviso',
  middleText: 'Contenido',
);
```

---
En conclusion, GetX es recomendable para proyectos donde se priorice un bajo peso en codigo verboso y un patron facil de estandarizar, ya que evita las configuraciones engorrosas de muchas tareas comunes (rutas, http, traducciones, estado, variables mutables) resolviendolo en una linea todo incluido en el mismo framework.
