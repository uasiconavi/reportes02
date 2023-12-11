import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;

List<List<dynamic>> completoCSV = [];

List<String> leerElementos(int columnaEstructura, BuildContext context) {
  leerCSV();
  String palabra = "";
  List<String> tiposElemento = [];

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
