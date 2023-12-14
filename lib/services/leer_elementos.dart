import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

List<List<dynamic>> completoCSV = [];

Future<List<String>> leerElementos(int columnaEstructura) async {
  leerCSV();
  List<String> elementos = [];
  if (completoCSV.isNotEmpty) {
    for (var i = 1; i < completoCSV.length; i++) {
      String palabra = completoCSV[i][columnaEstructura];
      if (palabra.isNotEmpty) {
        elementos.add(palabra);
      }
    }
  }
  return elementos;
}

void leerCSV() async {
  final rawData = await rootBundle.loadString("assets/elementos.csv");
  completoCSV = const CsvToListConverter().convert(rawData);
}
