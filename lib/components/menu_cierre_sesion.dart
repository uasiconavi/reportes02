import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import 'package:reportes02/main.dart';

class MenuCierreSesion extends StatefulWidget {
  const MenuCierreSesion({Key? key}) : super(key: key);

  @override
  State<MenuCierreSesion> createState() => _MenuCierreSesionState();
}

class _MenuCierreSesionState extends State<MenuCierreSesion> {
  @override
  Widget build(BuildContext context) {
    String usuario = context.watch<ReportProvider>().usuario;
    List<String> menu = [
      usuario,
      "Cerrar sesión",
    ];
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
          value: usuario,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 10.5,
          ),
          items: menu.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String? nuevoValor) {
            if (nuevoValor == "Cerrar sesión") {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("¿Desea cerrar la sesión?"),
                  actions: [
                    TextButton(
                      onPressed: signOut,
                      child: const Text(
                        "Sí",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "No",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }

  Future signOut() async {
    FirebaseAuth.instance.signOut().then((value) {
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    });
  }
}
