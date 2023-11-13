
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SessionService.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final sessionService = SessionService();
  String? _email;

  @override
  void initState() {
    super.initState();
    fetchSession();
  }

  void fetchSession() async {
    final email = await sessionService.readEmail();
    setState(() {
      _email = email;
    });
  }

  Future<void> _logout(BuildContext context) async {
    await sessionService.resetSession();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar( title: Text('Dashboard')),
      body: Center(
        child: Text('Hello $_email', style: TextStyle(
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