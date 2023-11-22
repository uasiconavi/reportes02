import 'package:flutter/material.dart';
import 'package:reportes02/screens/inicio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daños en la RVN',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const Inicio(),
    );
  }
}
