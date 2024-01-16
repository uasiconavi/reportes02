import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../services/services.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: context.watch<PaginationProvider>().titulo != "Fotos"
            ? backArrow(context)
            : null,
        title: Text(context.watch<PaginationProvider>().titulo),
        actions: const <Widget>[MenuCierreSesion()],
      ),
      body: context.watch<PaginationProvider>().currentPage,
    );
  }

  Widget backArrow(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        setState(() {
          context.read<PaginationProvider>().previousPage();
          context.read<PaginationProvider>().setTitulo();
        });
      },
    );
  }
}
