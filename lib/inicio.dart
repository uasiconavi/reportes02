import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/screens.dart';

class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) => Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return indicadorIniciando(context);
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error"));
            } else if (snapshot.hasData) {
              return const SelectionScreen();
            } else {
              return const SesionScreen();
            }
          }));
}

Widget indicadorIniciando(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: const [
      CircularProgressIndicator(
        semanticsLabel: "Iniciando sesión",
      ),
      SizedBox(height: 8.0),
      Text(
        "Iniciando sesión...",
        style: TextStyle(fontSize: 10.0),
        textAlign: TextAlign.center,
      )
    ],
  );
}
