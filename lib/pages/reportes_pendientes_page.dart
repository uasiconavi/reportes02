import 'package:flutter/material.dart';
import 'package:reportes02/pages/reporte_por_subir_page.dart';
import '../services/services.dart';
import '../components/components.dart';

class ReportesPendientesPage extends StatefulWidget {
  const ReportesPendientesPage({super.key});

  @override
  State<ReportesPendientesPage> createState() => _ReportesPendientesPageState();
}

class _ReportesPendientesPageState extends State<ReportesPendientesPage> {
  List<Reporte> reportes = [];
  @override
  Widget build(BuildContext context) {
    cargaReportes();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reportes pendientes"),
        actions: const <Widget>[MenuEsquinaPendientes()],
      ),
      body: reportes.isNotEmpty
          ? ListView(
              children: [
                const SizedBox(
                  height: 8.5,
                ),
                for (var reporte in reportes)
                  OutlinedButton(
                    child: Text(
                      reporte.fechaReporte.toString(),
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ReportePorSubirPage(reporte: reporte),
                        ),
                      );
                    },
                  ),
                const SizedBox(
                  height: 8.5,
                ),
                Center(
                  child: ElevatedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.cloud_upload_outlined),
                        SizedBox(width: 5.0),
                        Text("Subir todos"),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            )
          : const Center(
              child: Text(
                "No hay reportes pendientes",
                style: TextStyle(
                  fontSize: 17.0,
                ),
              ),
            ),
    );
  }

  cargaReportes() async {
    List<Reporte> auxReportes = await DB.reportes();

    setState(() {
      reportes = auxReportes;
    });
  }
}
