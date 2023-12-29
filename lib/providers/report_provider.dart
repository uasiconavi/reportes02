import 'package:flutter/material.dart';

class ReportProvider with ChangeNotifier {
  String _estructura = "Carretera";
  String _elemento = "";
  List<String> _listaElementos = [];
  bool _primeraVezEstructura = true;
  String _dano = "";
  List<String> _listaDanos = [];
  bool _primeraVezElemento = true;
  String _severidad = "";
  String _servicio = "";
  String _evento = "";
  String _fecha =
      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
  String _zona = "1-1 San José";
  String _ruta = "";
  List<String> _listaRutas = [];
  bool _primeraVezZona = true;
  String _seccion = "";
  List<String> _listaSecciones = [];
  bool _primeraVezRuta = true;

  String get estructura => _estructura;
  String get elemento => _elemento;
  List<String> get listaElementos => _listaElementos;
  bool get primeraVezEstructura => _primeraVezEstructura;
  String get dano => _dano;
  List<String> get listaDanos => _listaDanos;
  bool get primeraVezElemento => _primeraVezElemento;
  String get severidad => _severidad;
  String get servicio => _servicio;
  String get evento => _evento;
  String get fecha => _fecha;
  String get zona => _zona;
  String get ruta => _ruta;
  List<String> get listaRutas => _listaRutas;
  bool get primeraVezZona => _primeraVezZona;
  String get seccion => _seccion;
  List<String> get listaSecciones => _listaSecciones;
  bool get primeraVezRuta => _primeraVezRuta;

  void setEstructura(String newEstructura) {
    _estructura = newEstructura;
    notifyListeners();
  }

  void setElemento(String newElemento) {
    _elemento = newElemento;
    notifyListeners();
  }

  void setListaElementos(List<String> newListaElementos) {
    _listaElementos = newListaElementos;
    notifyListeners();
  }

  void setPrimeraVezEstructura(bool newPrimeraVezEstructura) {
    _primeraVezEstructura = newPrimeraVezEstructura;
    notifyListeners();
  }

  void setDano(String newDano) {
    _dano = newDano;
    notifyListeners();
  }

  void setListaDanos(List<String> newListaDanos) {
    _listaDanos = newListaDanos;
    notifyListeners();
  }

  void setPrimeraVezElemento(bool newPrimeraVezElemento) {
    _primeraVezElemento = newPrimeraVezElemento;
    notifyListeners();
  }

  void setSeveridad(String newSeveridad) {
    _severidad = newSeveridad;
    notifyListeners();
  }

  void setServicio(String newServicio) {
    _servicio = newServicio;
    notifyListeners();
  }

  void setEvento(String newEvento) {
    _evento = newEvento;
    notifyListeners();
  }

  void setFecha(String newFecha) {
    _fecha = newFecha;
    notifyListeners();
  }

  void setZona(String newZona) {
    _zona = newZona;
    notifyListeners();
  }

  void setRuta(String newRuta) {
    _ruta = newRuta;
    notifyListeners();
  }

  void setListaRutas(List<String> newListaRutas) {
    _listaRutas = newListaRutas;
    notifyListeners();
  }

  void setPrimeraVezZona(bool newPrimeraVezZona) {
    _primeraVezZona = newPrimeraVezZona;
    notifyListeners();
  }

  void setSeccion(String newSeccion) {
    _seccion = newSeccion;
    notifyListeners();
  }

  void setListaSecciones(List<String> newListaSecciones) {
    _listaSecciones = newListaSecciones;
    notifyListeners();
  }

  void setPrimeraVezRuta(bool newPrimeraVezRuta) {
    _primeraVezRuta = newPrimeraVezRuta;
    notifyListeners();
  }
}
