import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../pages/pages.dart';

class SesionScreen extends StatefulWidget {
  const SesionScreen({super.key});

  @override
  State<SesionScreen> createState() => _SesionScreenState();
}

class _SesionScreenState extends State<SesionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: context.watch<PaginationProvider>().inicioSesionPage == 0
            ? null
            : backArrow(context),
        title: context.watch<PaginationProvider>().inicioSesionPage == 0
            ? const Text("Inicio de sesión")
            : const Text("Cambio de contraseña"),
      ),
      body: context.watch<PaginationProvider>().inicioSesionPage == 0
          ? const InicioSesionPage()
          : const CambioContrasenaPage(),
    );
  }

  Widget backArrow(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        setState(() {
          context.read<PaginationProvider>().setInicioSesionPage(0);
        });
      },
    );
  }
}
