import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../components/components.dart';

class ElementoPage extends StatefulWidget {
  const ElementoPage({super.key});

  @override
  State<ElementoPage> createState() => _ElementoPageState();
}

class _ElementoPageState extends State<ElementoPage> {
  List<List<dynamic>> completoCSV = [];

  @override
  Widget build(BuildContext context) {
    int columnaEstructura = context.watch<ReportProvider>().columnaEstructura;
    leerCSV();
    List<String> tiposElemento = [];
    if (completoCSV.isNotEmpty) {
      for (var i = 1; i < completoCSV.length; i++) {
        String palabra = completoCSV[i][columnaEstructura];
        if (palabra.isNotEmpty) {
          tiposElemento.add(palabra);
        }
      }
    }

    return ListView(
      children: [
        encabezadoElemento(context),
        SizedBox(
          height: 570.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Elemento dañado de "${context.watch<ReportProvider>().estructura}":',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
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
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    borderRadius: BorderRadius.circular(9.0),
                    elevation: 3,
                    iconEnabledColor: Colors.blueGrey,
                    iconDisabledColor: Colors.white,
                    isExpanded: true,
                    isDense: true,
                    value: context.watch<ReportProvider>().elemento,
                    items: tiposElemento.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? nuevoValor) {
                      setState(() {
                        context.read<ReportProvider>().setElemento(nuevoValor!);
                      });
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

  void leerCSV() async {
    final rawData = await rootBundle.loadString("assets/elementos.csv");
    setState(() {
      completoCSV = const CsvToListConverter().convert(rawData);
    });
  }
}

Widget encabezadoElemento(BuildContext context) {
  return Container(
    margin: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Estructura: ',
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
      ],
    ),
  );
}
