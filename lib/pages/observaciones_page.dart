import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../components/components.dart';

class ObservacionesPage extends StatefulWidget {
  const ObservacionesPage({Key? key}) : super(key: key);

  @override
  State<ObservacionesPage> createState() => _ObservacionesPageState();
}

class _ObservacionesPageState extends State<ObservacionesPage> {
  TextEditingController observacionesController =
      TextEditingController(text: "");
  int longCaracteres = 254;
  bool guardando = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Encabezado(),
        /* encabezadoObservaciones(context),
        encabezadoUbicacionObservaciones(context), */
        const SizedBox(height: 10.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Observaciones y comentarios generales:',
              style: TextStyle(
                fontSize: 16.5,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(fontSize: 20.0),
                maxLength: 254,
                maxLines: 9,
                controller: observacionesController,
                onChanged: (String value) {
                  setState(() {
                    context.read<ReportProvider>().setObservaciones(value);
                    longCaracteres = 254 -
                        Provider.of<ReportProvider>(context, listen: false)
                            .observaciones
                            .length;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: "Máximo 254 caracteres",
                  helperText: "Nombre coloquial del sitio",
                  counterText: "${longCaracteres.toString()} caracter(es)",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Cantidad de fotos:  ',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      )),
                  Text('$longCaracteres',
                      style: const TextStyle(
                        fontSize: 13.0,
                      )),
                ],
              ),
            ),
            guardando == true
                ? _indicadorGuardando(context)
                : const BotonSiguiente(),
          ],
        ),
      ],
    );
  }
}

Widget _indicadorGuardando(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: const [
      CircularProgressIndicator(
        semanticsLabel: "Guardando reporte",
      ),
      SizedBox(height: 8.0),
      Text(
        "Guardando reporte...",
        style: TextStyle(fontSize: 10.0),
        textAlign: TextAlign.center,
      )
    ],
  );
}

Widget encabezadoObservaciones(BuildContext context) {
  return Container(
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
            Row(
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
            ),
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
  );
}

Widget encabezadoUbicacionObservaciones(BuildContext context) {
  return Padding(
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
  );
}
