import 'package:flutter/material.dart';

class NavStateHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nav tradicional')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navegación tradicional
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavStateDetail()),
            );
          },
          child: Text('Ir a Detalles'),
        ),
      ),
    );
  }
}

class NavStateDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalles')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Volver atrás
            Navigator.pop(context);
          },
          child: Text('Volver'),
        ),
      ),
    );
  }
}
