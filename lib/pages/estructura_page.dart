import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../components/components.dart';

class EstructuraPage extends StatefulWidget {
  const EstructuraPage({super.key});

  @override
  State<EstructuraPage> createState() => _EstructuraPageState();
}

class _EstructuraPageState extends State<EstructuraPage> {
  List<String> tiposEstructura = [
    "Carretera",
    "Puente",
    "Alcantarilla mayor",
    "Puente peatonal",
  ];

  @override
  Widget build(BuildContext context) {
    if (Provider.of<ReportProvider>(context, listen: false)
        .primeraVezEstructura) {
      _leerElementos(context);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text(
          "Tipo de estructura dañada:",
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 70.0),
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
              value: context.watch<ReportProvider>().estructura,
              items: tiposEstructura.map((String item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (String? nuevoValor) {
                context.read<ReportProvider>().setEstructura(nuevoValor!);
                context.read<ReportProvider>().setPrimeraVezEstructura(true);
                context.read<ReportProvider>().setPrimeraVezElemento(true);
              },
            ),
          ),
        ),
        const BotonSiguiente(),
      ],
    );
  }

  void _leerElementos(BuildContext context) async {
    int columnaEstructura = 0;
    List<List<dynamic>> completoCSV = [];
    List<String> listaElementos = [];
    final rawData = await rootBundle.loadString("assets/elementos.csv");
    setState(() {
      completoCSV = const CsvToListConverter().convert(rawData);
      switch (Provider.of<ReportProvider>(context, listen: false).estructura) {
        case "Carretera":
          columnaEstructura = 0;
          context.read<ReportProvider>().setElemento("Calzada");
          break;
        case "Puente":
          columnaEstructura = 1;
          context.read<ReportProvider>().setElemento("Bastiones");
          break;
        case "Alcantarilla mayor":
          columnaEstructura = 2;
          context.read<ReportProvider>().setElemento("Delantal");
          break;
        case "Puente peatonal":
          columnaEstructura = 3;
          context.read<ReportProvider>().setElemento("Apoyo paso principal");
          break;
      }
      if (completoCSV.isNotEmpty) {
        for (var i = 1; i < completoCSV.length; i++) {
          String palabra = completoCSV[i][columnaEstructura];
          if (palabra.isNotEmpty) {
            listaElementos.add(palabra);
          }
        }
      }
      context.read<ReportProvider>().setListaElementos(listaElementos);
    });
  }
}
