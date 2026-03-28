import 'package:flutter/material.dart';

class ApiListSetState extends StatefulWidget {
  @override
  _ApiListSetStateState createState() => _ApiListSetStateState();
}

class _ApiListSetStateState extends State<ApiListSetState> {
  List<String> _items = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    // Simulamos llamada a API
    await Future.delayed(Duration(seconds: 2));
    
    if (mounted) {
      setState(() {
        _items = ['Elemento 1', 'Elemento 2', 'Elemento 3'];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('API List con setState')),
      body: _isLoading 
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(_items[index]));
            },
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchData,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
