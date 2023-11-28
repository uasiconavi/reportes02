import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import '../providers/providers.dart';

class ElementoPage extends StatefulWidget {
  const ElementoPage({super.key});

  @override
  State<ElementoPage> createState() => _ElementoPageState();
}

class _ElementoPageState extends State<ElementoPage> {
  List<List<dynamic>> completoCSV = [];
  List<String> elementos = [];

  @override
  Widget build(BuildContext context) {
    leerCSV();
    llenarListaElementos();
    return ListView(
      children: [
        encabezado(context),
        SizedBox(
          height: 570.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Elemento dañado de:',
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
                    value: context.watch<ReportProvider>().elemento,
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
                    items: elementos.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? nuevoValor) {
                      setState(() {
                        context
                            .read<ReportProvider>()
                            .setEstructura(nuevoValor!);
                      });
                    },
                  ),
                ),
              ),
              botonSiguiente(context),
            ],
          ),
        ),
      ],
    );
  }

  void leerCSV() async {
    final rawData = await rootBundle.loadString("assets/elementos.csv");
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
    completoCSV = listData;
  }

  void llenarListaElementos() {
    String palabra = "";
    int columnaEstructura = context.watch<ReportProvider>().columnaEstructura;
    if (completoCSV.isNotEmpty) {
      for (var i = 1; i < completoCSV.length; i++) {
        palabra = completoCSV[i][columnaEstructura];
        if (palabra.isNotEmpty) {
          elementos.add(palabra);
        }
      }
    }
  }
}

Widget encabezado(BuildContext context) {
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

Widget botonSiguiente(BuildContext context) {
  return ElevatedButton(
    onPressed: () {},
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text("Siguiente"),
        SizedBox(width: 5.0),
        Icon(Icons.arrow_forward),
      ],
    ),
  );
}
