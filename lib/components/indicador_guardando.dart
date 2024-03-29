import 'package:flutter/material.dart';

Widget indicadorGuardando(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: const [
      CircularProgressIndicator(
        semanticsLabel: "Guardando reporte",
      ),
      SizedBox(height: 8.0),
      Text(
        "Guardando reporte...",
        style: TextStyle(fontSize: 10.0),
        textAlign: TextAlign.center,
      )
    ],
  );
}
