import 'package:flutter/material.dart';

class MenuEsquinaPendientes extends StatefulWidget {
  const MenuEsquinaPendientes({Key? key}) : super(key: key);

  @override
  State<MenuEsquinaPendientes> createState() => _MenuEsquinaPendientesState();
}

class _MenuEsquinaPendientesState extends State<MenuEsquinaPendientes> {
  @override
  Widget build(BuildContext context) {
    String valor = "Subir todos";
    List<String> menu = [
      valor,
    ];
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
          value: valor,
          style: const TextStyle(
            color: Colors.black,
          ),
          items: menu.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String? nuevoValor) {
            if (nuevoValor == "Subir todos") {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title:
                      const Text("¿Desea subir todos los reportes a la nube?"),
                  actions: [
                    TextButton(
                      onPressed: () {},
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
}
