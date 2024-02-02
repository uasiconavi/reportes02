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
