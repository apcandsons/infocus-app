import 'dart:async';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:uni_links/uni_links.dart';

import 'DashboardPage.dart';
import 'HomePage.dart';
import 'LoginPage.dart';
import 'SessionService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  final sessionService = SessionService();
  final logger = Logger();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  StreamSubscription? _sub;
  String? catchLink;

  @override void initState() {
    super.initState();
    _initUniLinks();
    _checkSessionAndNavigate();
  }

  Future<void> _initUniLinks() async {
    _sub = linkStream.listen((String? link) async {
      catchLink = link;
      final code = getQueryParameter(link!, 'code');
      logger.i('Got link: $link and code: $code. Navigating to dashboard.');
      await sessionService.exchangeCodeForAccessToken(code!);
      navigatorKey.currentState!.pushReplacementNamed('/dashboard');
    }, onError: (Object err) {
      logger.e('Got error while processing link stream: $err');
    });
  }

  String? getQueryParameter(String link, String key) {
    final uri = Uri.parse(link);
    return uri.queryParameters[key];
  }

  Future<void> _checkSessionAndNavigate() async {
    final hasLoggedIn = await sessionService.isAccessTokenValid();
    if (hasLoggedIn) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => DashboardPage(),
      },
      title: 'Infocus Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
      navigatorKey: navigatorKey,
    );
  }
}