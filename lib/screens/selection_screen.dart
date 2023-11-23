import 'package:flutter/material.dart';
import 'package:reportes02/pages/estructura_page.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  final List<Widget> _pages = <Widget>[
    const EstructuraPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Estructura"),
      ),
      body: _pages[0],
    );
  }
}
