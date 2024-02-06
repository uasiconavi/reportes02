import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../services/services.dart';
import 'package:flutter/services.dart';

class MensajeCerrarApp extends StatefulWidget {
  const MensajeCerrarApp({Key? key}) : super(key: key);

  @override
  State<MensajeCerrarApp> createState() => _MensajeCerrarAppState();
}

class _MensajeCerrarAppState extends State<MensajeCerrarApp> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      context.read<ReportProvider>().setGuardando(false);
    });
    return Container(
      child: _preguntar(context),
    );
    //return _preguntar(context);
  }

  _preguntar(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black54,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("¿Desea realizar otro reporte?"),
        actions: [
          TextButton(
            child: const Text(
              "Sí",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              limpiarVariables(context);
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text(
              "No (salir)",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
        ],
      ),
    );
  }
}
