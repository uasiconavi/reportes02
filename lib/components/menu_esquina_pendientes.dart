import 'package:flutter/material.dart';
import 'package:reportes02/components/components.dart';

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
              subirTodosPregunta(context);
            }
          }),
    );
  }
}
