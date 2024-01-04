import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';

class Encabezado extends StatelessWidget {
  const Encabezado({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int pagina = context.watch<PaginationProvider>().pagina;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Estructura:  ',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(context.watch<ReportProvider>().estructura,
                          style: const TextStyle(
                            fontSize: 12.0,
                          )),
                    ],
                  ),
                  pagina >= 2
                      ? Row(
                          children: [
                            const Text('Elemento: ',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(context.watch<ReportProvider>().elemento,
                                style: const TextStyle(
                                  fontSize: 11.0,
                                )),
                          ],
                        )
                      : const SizedBox(),
                  Row(
                    children: [
                      const Text('Daño: ',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(context.watch<ReportProvider>().dano,
                          style: const TextStyle(
                            fontSize: 12.0,
                          )),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Severidad:  ',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(context.watch<ReportProvider>().severidad,
                          style: const TextStyle(
                            fontSize: 12.0,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Servicio:  ',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(context.watch<ReportProvider>().servicio,
                          style: const TextStyle(
                            fontSize: 12.0,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Evento:  ',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(context.watch<ReportProvider>().evento,
                          style: const TextStyle(
                            fontSize: 12.0,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Fecha del evento:  ',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(context.watch<ReportProvider>().fecha,
                          style: const TextStyle(
                            fontSize: 10.0,
                          )),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Zona:  ',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(context.watch<ReportProvider>().zona,
                        style: const TextStyle(
                          fontSize: 13.0,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Ruta:  ',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(context.watch<ReportProvider>().ruta,
                        style: const TextStyle(
                          fontSize: 13.0,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Sección:  ',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(context.watch<ReportProvider>().seccion,
                        style: const TextStyle(
                          fontSize: 13.0,
                        )),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Latitud: ",
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${context.watch<ReportProvider>().ubicacion?.latitude.toStringAsFixed(4)}   ",
                        style: const TextStyle(
                          fontSize: 13.0,
                        ),
                      ),
                      const Text(
                        "Longitud: ",
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${context.watch<ReportProvider>().ubicacion?.longitude.toStringAsFixed(4)}",
                        style: const TextStyle(
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
