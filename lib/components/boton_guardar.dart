import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../services/services.dart';
import 'package:flutter/services.dart';

class BotonGuardar extends StatelessWidget {
  const BotonGuardar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.cloud_upload_outlined),
          SizedBox(width: 5.0),
          Text("Guardar"),
        ],
      ),
      onPressed: () {
        context.read<ReportProvider>().setGuardando(true);
        subirFotos(
          Provider.of<ReportProvider>(context, listen: false).usuario,
          Provider.of<ReportProvider>(context, listen: false).fotos,
        );
        reporteListo.then((value) {
          _mensajeCierreApp(context);
        });
      },
    );
  }

  _mensajeCierreApp(BuildContext context) {
    context.read<ReportProvider>().setGuardando(false);
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
