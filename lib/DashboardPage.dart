
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SessionService.dart';

class DashboardPage extends StatelessWidget {
  final sessionService = SessionService();

  Future<void> _logout(BuildContext context) async {
    await sessionService.resetSession();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text('Dashboard')),
      body: Center(
        child: Text('You are logged in!', style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _logout(context),
        tooltip: 'Logout',
        child: Icon(Icons.logout),
      ),
    );
  }
}