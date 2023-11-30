import 'package:flutter/material.dart';

class ReportProvider with ChangeNotifier {
  String _estructura = "Carretera";
  String _elemento = "Calzada";
  int _columnaEstructura = 0;

  String get estructura => _estructura;
  String get elemento => _elemento;
  int get columnaEstructura => _columnaEstructura;

  void setEstructura(String newEstructura) {
    _estructura = newEstructura;
    switch (_estructura) {
      case "Carretera":
        _elemento = "Calzada";
        _columnaEstructura = 0;
        break;
      case "Puente":
        _elemento = "Bastiones";
        _columnaEstructura = 1;
        break;
      case "Alcantarilla mayor":
        _elemento = "Delantal";
        _columnaEstructura = 2;
        break;
      case "Puente peatonal":
        _elemento = "Apoyo paso principal";
        _columnaEstructura = 3;
        break;
    }
    notifyListeners();
  }

  void setElemento(String newElemento) {
    _elemento = newElemento;
    notifyListeners();
  }
}
