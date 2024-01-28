import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/components.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';

class CambioContrasenaPage extends StatefulWidget {
  const CambioContrasenaPage({Key? key}) : super(key: key);

  @override
  State<CambioContrasenaPage> createState() => _CambioContrasenaPageState();
}

class _CambioContrasenaPageState extends State<CambioContrasenaPage> {
  final usuarioController = TextEditingController();

  @override
  void dispose() {
    usuarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const LogoTitulos(),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 30),
              child: TextFormField(
                controller: usuarioController,
                cursorColor: Colors.black,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintText: "Correo electrónico",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton.icon(
              onPressed: cambiarContrasena,
              icon: const Icon(Icons.email_outlined),
              label: const Text('Cambiar contraseña'),
            ),
          ],
        ),
      ],
    );
  }

  Future cambiarContrasena() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: usuarioController.text.trim(),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Correo de cambio de contraseña enviado"),
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      context.read<PaginationProvider>().setInicioSesionPage(0);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Correo electrónico inválido"),
        ),
      );
      // ignore: avoid_print
      print(e);
      Navigator.of(context).pop();
    }
  }
}
