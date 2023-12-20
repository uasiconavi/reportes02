import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../components/components.dart';

class DanoPage extends StatefulWidget {
  const DanoPage({super.key});

  @override
  State<DanoPage> createState() => _DanoPageState();
}

class _DanoPageState extends State<DanoPage> {
  List<List<dynamic>> completoCSV = [];

  @override
  Widget build(BuildContext context) {
    leerCSV();
    List<String> tiposDano = [];
    int columnaElemento = context.watch<ReportProvider>().columnaElemento;
    String palabra = "";

    if (completoCSV.isNotEmpty) {
      for (var i = 1; i < completoCSV.length; i++) {
        palabra = completoCSV[i][columnaElemento];
        if (palabra.isNotEmpty) {
          tiposDano.add(palabra);
        }
      }
    }
    return ListView(
      children: [
        encabezadoDano(context),
        SizedBox(
          height: 556.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Tipo de daño de "${context.watch<ReportProvider>().elemento}":',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
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
                    value: context.watch<ReportProvider>().dano,
                    items: tiposDano.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? nuevoValor) {
                      setState(() {
                        context.read<ReportProvider>().setDano(nuevoValor!);
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
    final rawData = await rootBundle.loadString("assets/danos.csv");
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
    setState(() {
      completoCSV = listData;
    });
  }
}

Widget encabezadoDano(BuildContext context) {
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
        Row(
          children: [
            const Text('Elemento:  ',
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
      ],
    ),
  );
}
