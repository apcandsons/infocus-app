
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  void _launchUrl() async {
    const path = 'https://app.infocus.biz/login?redirect_url=infocus://application/auth';
    // const path = 'http://localhost:3000/login?redirect_url=infocus://application/auth';
    final url = Uri.parse(path);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Login'),
          onPressed: _launchUrl,
        ),
      ),
    );
  }
}