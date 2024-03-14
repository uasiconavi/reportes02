import 'package:flutter/material.dart';
import 'package:reportes02/pages/reporte_por_subir_page.dart';
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
                  return OutlinedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        reportes[i].fechaReporte.toString(),
                        style: const TextStyle(
                          //decoration: TextDecoration.underline,
                          fontSize: 18.0,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ReportePorSubirPage(reporte: reportes[i])));
                    },
                  );
                })
            : const Center(
                child: Text(
                  "No hay reportes pendientes",
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
              ));
  }

  cargaReportes() async {
    List<Reporte> auxReportes = await DB.reportes();

    setState(() {
      reportes = auxReportes;
    });
  }
}
