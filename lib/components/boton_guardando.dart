import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../services/services.dart';

class BotonGuardando extends StatelessWidget {
  const BotonGuardando({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<ReportProvider>().setGuardando(true);
        guardarReporte(
          Provider.of<ReportProvider>(context, listen: false).usuario,
          Provider.of<ReportProvider>(context, listen: false).fotos,
          Provider.of<ReportProvider>(context, listen: false).estructura,
          Provider.of<ReportProvider>(context, listen: false).elemento,
          Provider.of<ReportProvider>(context, listen: false).dano,
          Provider.of<ReportProvider>(context, listen: false).severidad,
          Provider.of<ReportProvider>(context, listen: false).servicio,
          Provider.of<ReportProvider>(context, listen: false).evento,
          Provider.of<ReportProvider>(context, listen: false).fecha,
          Provider.of<ReportProvider>(context, listen: false).zona,
          Provider.of<ReportProvider>(context, listen: false).ruta,
          Provider.of<ReportProvider>(context, listen: false).seccion,
          Provider.of<ReportProvider>(context, listen: false).ubicacion,
          Provider.of<ReportProvider>(context, listen: false).observaciones,
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.cloud_upload_outlined),
          SizedBox(width: 5.0),
          Text("Guardar"),
        ],
      ),
    );
  }
}
