import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';

class BotonSiguiente extends StatefulWidget {
  const BotonSiguiente({super.key});

  @override
  State<BotonSiguiente> createState() => _BotonSiguienteState();
}

class _BotonSiguienteState extends State<BotonSiguiente> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<PaginationProvider>().nextPage();
        context.read<PaginationProvider>().setTitulo();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text("Siguiente"),
          SizedBox(width: 5.0),
          Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}
