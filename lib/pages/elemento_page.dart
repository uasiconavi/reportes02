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
  @override
  Widget build(BuildContext context) {
    if (Provider.of<ReportProvider>(context, listen: false)
        .primeraVezElemento) {
      _leerDanos(context);
    }
    return ListView(
      children: [
        const Encabezado(),
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
                    items: context
                        .watch<ReportProvider>()
                        .listaElementos
                        .map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? nuevoValor) {
                      context.read<ReportProvider>().setElemento(nuevoValor!);
                      context
                          .read<ReportProvider>()
                          .setPrimeraVezElemento(true);
                      context
                          .read<ReportProvider>()
                          .setPrimeraVezEstructura(false);
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

  void _leerDanos(BuildContext context) async {
    int columnaElemento = 0;
    List<List<dynamic>> completoCSV = [];
    List<String> listaDanos = [];
    final rawData = await rootBundle.loadString("assets/danos.csv");
    setState(() {
      completoCSV = const CsvToListConverter().convert(rawData);
      switch (Provider.of<ReportProvider>(context, listen: false).elemento) {
        case "Alcantarilla":
          columnaElemento = 0;
          context.read<ReportProvider>().setDano("Obstrucción");
          break;
        case "Calzada":
          columnaElemento = 1;
          context.read<ReportProvider>().setDano("Hundimiento");
          break;
        case "Cuneta":
          columnaElemento = 2;
          context.read<ReportProvider>().setDano("Excede la capacidad");
          break;
        case "Contracuneta":
          columnaElemento = 3;
          context.read<ReportProvider>().setDano("Colapso");
          break;
        case "Muro":
          columnaElemento = 4;
          context.read<ReportProvider>().setDano("Agrietamiento");
          break;
        case "Relleno":
          columnaElemento = 5;
          context.read<ReportProvider>().setDano("Asentamiento");
          break;
        case "Talud":
          columnaElemento = 6;
          context.read<ReportProvider>().setDano("Derrumbe");
          break;
        case "Vado":
          columnaElemento = 7;
          context.read<ReportProvider>().setDano("Erosión (grada)");
          break;
        case "Apoyos":
          columnaElemento = 8;
          context.read<ReportProvider>().setDano("Deformación");
          break;
        case "Bastiones":
          columnaElemento = 9;
          context.read<ReportProvider>().setDano("Socavación");
          break;
        case "Elementos de protección":
          columnaElemento = 10;
          context.read<ReportProvider>().setDano("Agrietamiento");
          break;
        case "Márgenes":
          columnaElemento = 11;
          context.read<ReportProvider>().setDano("Modificación del cauce");
          break;
        case "Pilas":
          columnaElemento = 12;
          context.read<ReportProvider>().setDano("Socavación");
          break;
        case "Relleno de aproximación":
          columnaElemento = 13;
          context.read<ReportProvider>().setDano("Hundimiento");
          break;
        case "Superestructura":
          columnaElemento = 14;
          context.read<ReportProvider>().setDano("Falla de elemento de acero");
          break;
        case "Pasarela peatonal":
          columnaElemento = 15;
          context.read<ReportProvider>().setDano("Agrietamiento estructural");
          break;
        case "Aletones":
          columnaElemento = 16;
          context.read<ReportProvider>().setDano("Acumulación de escombros");
          break;
        case "Delantal":
          columnaElemento = 17;
          context.read<ReportProvider>().setDano("Socavación");
          break;
        case "Rellenos":
          columnaElemento = 18;
          context.read<ReportProvider>().setDano("Pérdida parcial del relleno");
          break;
        case "Estructura principal":
          columnaElemento = 19;
          context.read<ReportProvider>().setDano("Deformación (acero)");
          break;
        case "Accesos":
          columnaElemento = 20;
          context.read<ReportProvider>().setDano("Colapso");
          break;
        case "Súper-estructura":
          columnaElemento = 21;
          context.read<ReportProvider>().setDano("Desplazamiento");
          break;
        case "Apoyo paso principal":
          columnaElemento = 22;
          context.read<ReportProvider>().setDano("Inclinación");
          break;
        case "Apoyos intermedios":
          columnaElemento = 23;
          context.read<ReportProvider>().setDano("Agrietamiento estructural");
          break;
      }
      if (completoCSV.isNotEmpty) {
        for (var i = 1; i < completoCSV.length; i++) {
          String palabra = completoCSV[i][columnaElemento];
          if (palabra.isNotEmpty) {
            listaDanos.add(palabra);
          }
        }
      }
      context.read<ReportProvider>().setListaDanos(listaDanos);
      context.read<ReportProvider>().setSeveridad("Baja");
      context.read<ReportProvider>().setServicio("Habilitado");
      context.read<ReportProvider>().setEvento("Lluvia");
    });
  }
}
