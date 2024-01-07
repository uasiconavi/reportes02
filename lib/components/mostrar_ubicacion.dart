import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';

class MostrarUbicacion extends StatelessWidget {
  const MostrarUbicacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Latitud: ",
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "${context.watch<ReportProvider>().ubicacion?.latitude.toStringAsFixed(4)},   ",
          style: const TextStyle(
            fontSize: 15.0,
          ),
        ),
        const Text(
          "Longitud: ",
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "${context.watch<ReportProvider>().ubicacion?.longitude.toStringAsFixed(4)}",
          style: const TextStyle(
            fontSize: 15.0,
          ),
        ),
      ],
    );
  }
}
