import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/report_providers.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text(
          "Tipo de estructura dañada:",
          //textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            //color: Colors.black87,
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
              value: context.watch<ReportProvider>().estructura.isNotEmpty
                  ? context.watch<ReportProvider>().estructura
                  : tiposEstructura[0],
              items: tiposEstructura.map((String item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (String? nuevoValor) {
                setState(() {
                  context.read<ReportProvider>().setEstructura(nuevoValor!);
                });
              },
            ),
          ),
        ),
        botonSiguiente(context),
      ],
    );
  }
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
