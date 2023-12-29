import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../components/components.dart';

class RutaPage extends StatefulWidget {
  const RutaPage({Key? key}) : super(key: key);

  @override
  State<RutaPage> createState() => _RutaPageState();
}

class _RutaPageState extends State<RutaPage> {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<ReportProvider>(context, listen: false).primeraVezRuta) {
      _leerSecciones(context.watch<ReportProvider>().zona,
          context.watch<ReportProvider>().ruta, context);
    }
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
                    items: context
                        .watch<ReportProvider>()
                        .listaRutas
                        .map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? nuevoValor) {
                      context.read<ReportProvider>().setRuta(nuevoValor!);
                      context.read<ReportProvider>().setPrimeraVezRuta(true);
                      context.read<ReportProvider>().setPrimeraVezZona(false);
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

  _leerSecciones(String zona, String ruta, BuildContext context) async {
    ByteData data = await rootBundle.load("assets/rvn.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);
    var hoja = excel['sec']; //hoja del archivo de Excel con las secciones
    int col = 0; //la que avanza una a una
    int columna1 = 0; //columna de la zona que busco
    int columna2 = 0; //columna de la zona siguiente
    bool primeraCol2 = true; //para que solo entre una vez
    String palabra = ""; //variable utilizada para comparar cada celda
    List<String> listaSecciones = []; //lista de secciones para llenar

    //en este ciclo ubico esas dos columnas en el Excel
    hoja.row(0).forEach((Data? cell) {
      col++;
      if (cell != null) {
        palabra = cell.value.toString();
        if (zona == palabra) {
          columna1 = col;
        } else {
          if (primeraCol2 == true && columna1 != 0) {
            columna2 = col;
            primeraCol2 = false;
          }
        }
      }
    });

    // en este otro ciclo encuentro la columna de la ruta que busco
    col = 0;
    hoja.row(1).forEach((Data? cell) {
      col++;
      if (cell != null) {
        if (col >= columna1 && col < columna2) {
          palabra = cell.value.toString();
          if (ruta == palabra) {
            columna1 = col;
          }
        }
      }
    });

    var celda = hoja.cell;

//en este ciclo voy llenando la lista de las secciones encontradas en esa columna
    for (var i = 2; i < hoja.maxCols; i++) {
      palabra = celda(CellIndex.indexByColumnRow(
              columnIndex: columna1 - 1, rowIndex: i))
          .value
          .toString();
      if (palabra != 'null') {
        listaSecciones.add(palabra.toString());
      } else {
        break;
      }
    }
    setState(() {
      context.read<ReportProvider>().setListaSecciones(listaSecciones);
      context.read<ReportProvider>().setSeccion(listaSecciones[0]);
    });
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
