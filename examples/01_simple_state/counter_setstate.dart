import 'package:flutter/material.dart';

class CounterSetState extends StatefulWidget {
  @override
  _CounterSetStateState createState() => _CounterSetStateState();
}

class _CounterSetStateState extends State<CounterSetState> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter con setState')),
      body: Center(
        child: Text('Contador: $_counter', style: TextStyle(fontSize: 24)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: Icon(Icons.add),
      ),
    );
  }
}
