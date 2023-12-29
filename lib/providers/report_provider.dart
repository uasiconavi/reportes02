import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ReportProvider with ChangeNotifier {
  bool _primeraVezEstructura = true;
  String _estructura = "Carretera";
  bool _primeraVezElemento = true;
  String _elemento = "";
  List<String> _listaElementos = [];
  String _dano = "";
  List<String> _listaDanos = [];
  String _severidad = "";
  String _servicio = "";
  String _evento = "";
  String _fecha =
      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
  bool _primeraVezZona = true;
  String _zona = "1-1 San José";
  bool _primeraVezRuta = true;
  String _ruta = "";
  List<String> _listaRutas = [];
  String _seccion = "";
  List<String> _listaSecciones = [];
  Position? _ubicacion;

  bool get primeraVezEstructura => _primeraVezEstructura;
  String get estructura => _estructura;
  bool get primeraVezElemento => _primeraVezElemento;
  String get elemento => _elemento;
  List<String> get listaElementos => _listaElementos;
  String get dano => _dano;
  List<String> get listaDanos => _listaDanos;
  String get severidad => _severidad;
  String get servicio => _servicio;
  String get evento => _evento;
  String get fecha => _fecha;
  bool get primeraVezZona => _primeraVezZona;
  String get zona => _zona;
  bool get primeraVezRuta => _primeraVezRuta;
  String get ruta => _ruta;
  List<String> get listaRutas => _listaRutas;
  String get seccion => _seccion;
  List<String> get listaSecciones => _listaSecciones;
  Position? get ubicacion => _ubicacion;

  void setPrimeraVezEstructura(bool newPrimeraVezEstructura) {
    _primeraVezEstructura = newPrimeraVezEstructura;
    notifyListeners();
  }

  void setEstructura(String newEstructura) {
    _estructura = newEstructura;
    notifyListeners();
  }

  void setPrimeraVezElemento(bool newPrimeraVezElemento) {
    _primeraVezElemento = newPrimeraVezElemento;
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

  void setDano(String newDano) {
    _dano = newDano;
    notifyListeners();
  }

  void setListaDanos(List<String> newListaDanos) {
    _listaDanos = newListaDanos;
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

  void setPrimeraVezZona(bool newPrimeraVezZona) {
    _primeraVezZona = newPrimeraVezZona;
    notifyListeners();
  }

  void setZona(String newZona) {
    _zona = newZona;
    notifyListeners();
  }

  void setPrimeraVezRuta(bool newPrimeraVezRuta) {
    _primeraVezRuta = newPrimeraVezRuta;
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

  void setSeccion(String newSeccion) {
    _seccion = newSeccion;
    notifyListeners();
  }

  void setListaSecciones(List<String> newListaSecciones) {
    _listaSecciones = newListaSecciones;
    notifyListeners();
  }

  void setUbicacion(Position? newUbicacion) {
    _ubicacion = newUbicacion;
    notifyListeners();
  }
}
