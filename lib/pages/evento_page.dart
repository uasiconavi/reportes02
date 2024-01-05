import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../components/components.dart';

class EventoPage extends StatefulWidget {
  const EventoPage({super.key});

  @override
  State<EventoPage> createState() => _EventoPageState();
}

class _EventoPageState extends State<EventoPage> {
  List<String> tiposEvento = [
    "Lluvia",
    "Marea alta",
    "Sismo",
    "Vulcanismo",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Encabezado(),
        SizedBox(
          height: 541.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Evento disparador del daño:',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 80),
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
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                    borderRadius: BorderRadius.circular(9.0),
                    elevation: 3,
                    iconEnabledColor: Colors.blueGrey,
                    iconDisabledColor: Colors.white,
                    isExpanded: true,
                    isDense: true,
                    value: context.watch<ReportProvider>().evento,
                    items: tiposEvento.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? nuevoValor) {
                      context.read<ReportProvider>().setEvento(nuevoValor!);
                    },
                  ),
                ),
              ),
              const BotonSiguiente(),
            ],
          ),
        ),
      ],
    );
  }
}

Widget encabezadoEvento(BuildContext context) {
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
                      fontSize: 12.0,
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
          ],
        ),
      ],
    ),
  );
}
