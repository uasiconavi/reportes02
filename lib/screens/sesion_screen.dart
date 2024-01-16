import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import 'package:reportes02/main.dart';
import 'package:restart_app/restart_app.dart';

class SesionScreen extends StatefulWidget {
  const SesionScreen({super.key});

  @override
  State<SesionScreen> createState() => _SesionScreenState();
}

class _SesionScreenState extends State<SesionScreen> {
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
    return Scaffold(
      appBar: AppBar(title: const Text("Inicio de sesión")),
      body: ListView(
        children: [
          logo(),
          titulos(),
          Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
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
                  /* Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PageContrasena())); */
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future signIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: usuarioController.text.trim(),
              password: contrasenaController.text.trim())
          .then((value) {
        context
            .read<ReportProvider>()
            .addUsuario(FirebaseAuth.instance.currentUser!.email!);
      }).then((value) => Restart.restartApp);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Credenciales inválidas"),
        ),
      );
      // ignore: avoid_print
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

Widget logo() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 30.0),
    child: Image.asset(
      "assets/icon.png",
      height: 110.0,
    ),
  );
}

Widget titulos() {
  return Column(
    children: const [
      Text(
          "Reportes de daños en la Red Vial Nacional causados por eventos naturales",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          )),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Text("Consejo Nacional de Vialidad",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
            )),
      ),
    ],
  );
}
