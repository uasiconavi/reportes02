import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/report_providers.dart';
import 'screens/screens.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => ReportProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daños en la RVN',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const SelectionScreen(),
    );
  }
}
