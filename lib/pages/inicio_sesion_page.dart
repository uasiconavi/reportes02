import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/services.dart';
import '../components/components.dart';
import 'package:reportes02/main.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';

class InicioSesionPage extends StatefulWidget {
  const InicioSesionPage({super.key});

  @override
  State<InicioSesionPage> createState() => _InicioSesionPageState();
}

class _InicioSesionPageState extends State<InicioSesionPage> {
  final usuarioController = TextEditingController();
  final contrasenaController = TextEditingController();

  @override
  void dispose() {
    usuarioController.dispose();
    contrasenaController.dispose();

    super.dispose();
  }

  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const LogoTitulos(),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
              child: TextField(
                controller: usuarioController,
                cursorColor: Colors.black,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                decoration: const InputDecoration(
                  hintText: "Correo electrónico",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black26,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
              child: TextField(
                controller: contrasenaController,
                cursorColor: Colors.black,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  hintText: "Contraseña",
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black26,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black38,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton.icon(
              onPressed: signIn,
              icon: const Icon(Icons.lock_open),
              label: const Text('Inicio'),
            ),
            const SizedBox(height: 30.0),
            GestureDetector(
              child: const Text(
                'Cambiar contraseña',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 13.0,
                ),
              ),
              onTap: () {
                context.read<PaginationProvider>().setInicioSesionPage(1);
              },
            ),
          ],
        ),
      ],
    );
  }

  Future signIn() async {
    showDialog(
      context: navigatorKey.currentContext!, //evita error de unmounted
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: usuarioController.text.trim(),
              password: contrasenaController.text.trim())
          .then((value) => limpiarVariables(context));
    } on FirebaseAuthException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Credenciales inválidas"),
        ),
      );
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
