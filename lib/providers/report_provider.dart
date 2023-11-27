import 'package:flutter/material.dart';

class ReportProvider with ChangeNotifier {
  String _estructura = "Carretera";

  String get estructura => _estructura;

  void setEstructura(String newEstructura) {
    _estructura = newEstructura;
    notifyListeners();
  }
}
