
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Infocus'),
      ),
      body: Center(
        child: Text('Welcome', style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.login),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/login');
        },
      ),
    );
  }
}