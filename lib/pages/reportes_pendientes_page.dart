import 'package:flutter/material.dart';
import 'package:reportes02/pages/reporte_por_guardar_page.dart';
import '../services/services.dart';

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
      ),
      body: reportes.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: reportes.length,
              itemBuilder: (context, i) {
                return Center(
                  child: GestureDetector(
                    child: Text(
                      reportes[i].observaciones.toString(),
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 17.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ReportePorGuardarPage(reporte: reportes[i])));
                    },
                  ),
                );
              })
          : const Text("No hay reportes pendientes"),
    );
  }

  cargaReportes() async {
    List<Reporte> auxReportes = await DB.reportes();

    setState(() {
      reportes = auxReportes;
    });
  }
}
