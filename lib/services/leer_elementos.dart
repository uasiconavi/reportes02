import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import '../providers/providers.dart';

List<List<dynamic>> completoCSV = [];

List<String> leerElementos(BuildContext context) {
  leerCSV();
  List<String> tiposElemento = [];
  int columnaEstructura = context.watch<ReportProvider>().columnaEstructura;
  String palabra = "";

  if (completoCSV.isNotEmpty) {
    for (var i = 1; i < completoCSV.length; i++) {
      palabra = completoCSV[i][columnaEstructura];
      if (palabra.isNotEmpty) {
        tiposElemento.add(palabra);
      }
    }
  }
  return tiposElemento;
}

void leerCSV() async {
  final rawData = await rootBundle.loadString("assets/elementos.csv");
  List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
  completoCSV = listData;
}
