import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';

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
        leading: /* context.watch<PaginationProvider>().currentPage != EstructuraPage() ? */ IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            context.read<PaginationProvider>().previousPage();
          },
        ),
        title: const Text("Estructura"),
      ),
      body: context.watch<PaginationProvider>().currentPage,
    );
  }
}
