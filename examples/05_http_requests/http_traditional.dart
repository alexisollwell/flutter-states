import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpTraditional extends StatefulWidget {
  @override
  _HttpTraditionalState createState() => _HttpTraditionalState();
}

class _HttpTraditionalState extends State<HttpTraditional> {
  List<dynamic> _users = [];
  bool _isLoading = false;

  void fetchUsers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Necesita la libreria externa http
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      
      if (response.statusCode == 200) {
        // Necesita dart:convert y parseo manual
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _users = data;
        });
      }
    } catch (e) {
      print('Error en peticion HTTP tradicional: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Peticiones HTTP: Tradicional')),
      body: _isLoading 
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: _users.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_users[index]['name']),
                subtitle: Text(_users[index]['email']),
              );
            },
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
        child: Icon(Icons.download),
      ),
    );
  }
}
