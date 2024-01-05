import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../components/components.dart';

class FechaPage extends StatefulWidget {
  const FechaPage({super.key});

  @override
  State<FechaPage> createState() => _FechaPageState();
}

class _FechaPageState extends State<FechaPage> {
  DateTime? fechaEvento = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Encabezado(),
        SizedBox(
          height: 540.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Fecha aproximada del evento disparador:',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                context.watch<ReportProvider>().fecha,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _seleccion(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.calendar_month),
                    SizedBox(width: 5.0),
                    Text("Calendario"),
                  ],
                ),
              ),
              const BotonSiguiente(),
            ],
          ),
        ),
      ],
    );
  }

  _seleccion(BuildContext context) async {
    DateTime? seleccionada = await showDatePicker(
        context: context,
        locale: const Locale("es", "ES"),
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2025),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark(),
            child: child!,
          );
        });
    setState(() {
      if (seleccionada != null && seleccionada.compareTo(DateTime.now()) >= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No seleccione fechas futuras"),
          ),
        );
      } else {
        fechaEvento = seleccionada;
        if (fechaEvento != null) {
          context.read<ReportProvider>().setFecha(
              "${fechaEvento!.day}/${fechaEvento!.month}/${fechaEvento!.year}");
        }
      }
    });
  }
}

Widget encabezadoFecha(BuildContext context) {
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
          ],
        ),
      ],
    ),
  );
}
