import 'package:flutter/material.dart';
//import 'package:excel/excel.dart';
//import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:provider/provider.dart';
import '../providers/providers.dart';
//import '../components/components.dart';

class RutaPage extends StatefulWidget {
  const RutaPage({Key? key}) : super(key: key);

  @override
  State<RutaPage> createState() => _RutaPageState();
}

class _RutaPageState extends State<RutaPage> {
  @override
  Widget build(BuildContext context) {
    List<String> listaRutas = context.watch<ReportProvider>().listaRutas;
    return ListView(
      children: [
        encabezadoRuta(context),
        encabezadoUbicacionRuta(context),
        SizedBox(
          height: 458.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Ruta nacional de la zona "${context.watch<ReportProvider>().zona}":',
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 120),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black87,
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.circular(9.0)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black87,
                    ),
                    iconSize: 40.0,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    borderRadius: BorderRadius.circular(9.0),
                    elevation: 3,
                    iconEnabledColor: Colors.blueGrey,
                    iconDisabledColor: Colors.white,
                    isExpanded: true,
                    isDense: true,
                    value: context.watch<ReportProvider>().ruta,
                    items: listaRutas.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? nuevoValor) {
                      context.read<ReportProvider>().setRuta(nuevoValor!);
                    },
                  ),
                ),
              ),
              //const BotonSiguiente(),
            ],
          ),
        ),
      ],
    );
  }
}

Widget encabezadoRuta(BuildContext context) {
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

Widget encabezadoUbicacionRuta(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 14.0),
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
      ],
    ),
  );
}
