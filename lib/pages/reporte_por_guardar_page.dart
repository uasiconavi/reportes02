import 'package:flutter/material.dart';
import '../services/services.dart';

class ReportePorGuardarPage extends StatefulWidget {
  final Reporte reporte;
  const ReportePorGuardarPage({required this.reporte, Key? key})
      : super(key: key);

  @override
  State<ReportePorGuardarPage> createState() => _ReportePorGuardarPageState();
}

class _ReportePorGuardarPageState extends State<ReportePorGuardarPage> {
  @override
  Widget build(BuildContext context) {
    double tamanoLetra = 17.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reporte por guardar"),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Text('Fecha del reporte:  ',
                  style: TextStyle(
                    fontSize: tamanoLetra,
                    fontWeight: FontWeight.bold,
                  )),
              Text(widget.reporte.fechaReporte.toString(),
                  style: TextStyle(
                    fontSize: tamanoLetra,
                  )),
            ],
          ),
          Row(
            children: [
              Text('Estructura: ',
                  style: TextStyle(
                    fontSize: tamanoLetra,
                    fontWeight: FontWeight.bold,
                  )),
              Text(widget.reporte.estructura.toString(),
                  style: TextStyle(
                    fontSize: tamanoLetra,
                  )),
            ],
          ),
          Row(
            children: [
              Text('Elemento: ',
                  style: TextStyle(
                    fontSize: tamanoLetra,
                    fontWeight: FontWeight.bold,
                  )),
              Text(widget.reporte.elemento.toString(),
                  style: TextStyle(
                    fontSize: tamanoLetra,
                  )),
            ],
          ),
          Row(
            children: [
              Text('Daño: ',
                  style: TextStyle(
                    fontSize: tamanoLetra,
                    fontWeight: FontWeight.bold,
                  )),
              Text(widget.reporte.dano.toString(),
                  style: TextStyle(
                    fontSize: tamanoLetra,
                  )),
            ],
          ),
          Row(
            children: [
              Text('Severidad: ',
                  style: TextStyle(
                    fontSize: tamanoLetra,
                    fontWeight: FontWeight.bold,
                  )),
              Text(widget.reporte.severidad.toString(),
                  style: TextStyle(
                    fontSize: tamanoLetra,
                  )),
            ],
          ),
          Row(
            children: [
              Text('Servicio: ',
                  style: TextStyle(
                    fontSize: tamanoLetra,
                    fontWeight: FontWeight.bold,
                  )),
              Text(widget.reporte.servicio.toString(),
                  style: TextStyle(
                    fontSize: tamanoLetra,
                  )),
            ],
          ),
          Row(
            children: [
              Text('Evento: ',
                  style: TextStyle(
                    fontSize: tamanoLetra,
                    fontWeight: FontWeight.bold,
                  )),
              Text(widget.reporte.evento.toString(),
                  style: TextStyle(
                    fontSize: tamanoLetra,
                  )),
            ],
          ),
          Row(
            children: [
              Text('Fecha del evento: ',
                  style: TextStyle(
                    fontSize: tamanoLetra,
                    fontWeight: FontWeight.bold,
                  )),
              Text(widget.reporte.fechaEvento.toString(),
                  style: TextStyle(
                    fontSize: tamanoLetra,
                  )),
            ],
          ),
          Row(
            children: [
              Text('Zona: ',
                  style: TextStyle(
                    fontSize: tamanoLetra,
                    fontWeight: FontWeight.bold,
                  )),
              Text(widget.reporte.zona.toString(),
                  style: TextStyle(
                    fontSize: tamanoLetra,
                  )),
            ],
          ),
          Row(
            children: [
              Text('Ruta: ',
                  style: TextStyle(
                    fontSize: tamanoLetra,
                    fontWeight: FontWeight.bold,
                  )),
              Text(widget.reporte.ruta.toString(),
                  style: TextStyle(
                    fontSize: tamanoLetra,
                  )),
            ],
          ),
          Row(
            children: [
              Text('Sección: ',
                  style: TextStyle(
                    fontSize: tamanoLetra,
                    fontWeight: FontWeight.bold,
                  )),
              Text(widget.reporte.seccion.toString(),
                  style: TextStyle(
                    fontSize: tamanoLetra,
                  )),
            ],
          ),
          Row(
            children: [
              Text('Latitud: ',
                  style: TextStyle(
                    fontSize: tamanoLetra,
                    fontWeight: FontWeight.bold,
                  )),
              Text(widget.reporte.latitud.toString(),
                  style: TextStyle(
                    fontSize: tamanoLetra,
                  )),
            ],
          ),
          Row(
            children: [
              Text('Longitud: ',
                  style: TextStyle(
                    fontSize: tamanoLetra,
                    fontWeight: FontWeight.bold,
                  )),
              Text(widget.reporte.longitud.toString(),
                  style: TextStyle(
                    fontSize: tamanoLetra,
                  )),
            ],
          ),
          Row(
            children: [
              Text('Observaciones: ',
                  style: TextStyle(
                    fontSize: tamanoLetra,
                    fontWeight: FontWeight.bold,
                  )),
              Text(widget.reporte.observaciones.toString(),
                  style: TextStyle(
                    fontSize: tamanoLetra,
                  )),
            ],
          ),
          const SizedBox(height: 20.0),
          Center(
            child: ElevatedButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.cloud_upload_outlined),
                  SizedBox(width: 5.0),
                  Text("Guardar"),
                ],
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
