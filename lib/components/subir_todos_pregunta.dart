import 'package:flutter/material.dart';

subirTodosPregunta(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    barrierColor: Colors.black54,
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("¿Desea subir todos los reportes a la nube?"),
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
