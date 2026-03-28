import 'package:flutter/material.dart';

class UtilsSetState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Utils Tradicional')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Snackbar tradicional (requiere context en el árbol correcto)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Hola, soy un SnackBar')),
                );
              },
              child: Text('Mostrar SnackBar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Dialog tradicional
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Alerta'),
                      content: Text('Este es un dialog tradicional'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Cerrar'),
                        )
                      ],
                    );
                  },
                );
              },
              child: Text('Mostrar Dialog'),
            ),
          ],
        ),
      ),
    );
  }
}
