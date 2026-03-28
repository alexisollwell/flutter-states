import 'package:flutter/material.dart';

class ThemeLangTraditional extends StatefulWidget {
  @override
  _ThemeLangTraditionalState createState() => _ThemeLangTraditionalState();
}

class _ThemeLangTraditionalState extends State<ThemeLangTraditional> {
  // Tradicionalmente, este estado tendria que ubicarse muy alto en tu arbol (raiz)
  // o requeririas un Gestor de Estado extra (como Provider)
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    // Si hubieras usado flutter_localizations e intl, el texto quedaria asi:
    // String textoHola = AppLocalizations.of(context)!.helloWorld;
    // Esto significa que necesitas el config completo para obtener traducciones

    return Scaffold(
      appBar: AppBar(
        title: Text('Tema e Idioma: Tradicional'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Para cambiar tema ocupas Provider o state global'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aqui tendrias que tener una funcion en un InheritedWidget de mas nivel
                setState(() {
                  isDark = !isDark;
                });
              },
              child: Text('Simular cambio de tema'),
            ),
          ],
        ),
      ),
    );
  }
}
