import 'package:flutter/material.dart';
import '../services/services.dart';

class ReportePorSubirPage extends StatefulWidget {
  final Reporte reporte;
  const ReportePorSubirPage({required this.reporte, Key? key})
      : super(key: key);

  @override
  State<ReportePorSubirPage> createState() => _ReportePorSubirPageState();
}

class _ReportePorSubirPageState extends State<ReportePorSubirPage> {
  @override
  Widget build(BuildContext context) {
    double tamanoLetra = 18.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reporte por subir"),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 550.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (widget.reporte.fotos != null &&
                    widget.reporte.fotos!.isNotEmpty)
                  SizedBox(
                    height: 100.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.reporte.fotos!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.file(
                            widget.reporte.fotos![index],
                            width: 75.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
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
                          Text(
                              "${widget.reporte.latitud!.toStringAsFixed(4)},   ",
                              style: TextStyle(
                                fontSize: tamanoLetra,
                              )),
                          Text('Longitud: ',
                              style: TextStyle(
                                fontSize: tamanoLetra,
                                fontWeight: FontWeight.bold,
                              )),
                          Text(widget.reporte.longitud!.toStringAsFixed(4),
                              style: TextStyle(
                                fontSize: tamanoLetra,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text('Observaciones: ',
                        style: TextStyle(
                          fontSize: tamanoLetra,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 4.0),
                    SizedBox(
                      width: 390.0,
                      child: Text(widget.reporte.observaciones.toString(),
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: tamanoLetra,
                          ),
                          maxLines: 8,
                          overflow: TextOverflow.visible),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: ElevatedButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.cloud_upload_outlined),
                  SizedBox(width: 5.0),
                  Text("Subir"),
                ],
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
