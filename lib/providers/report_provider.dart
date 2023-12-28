import 'package:flutter/material.dart';

class ReportProvider with ChangeNotifier {
  String _estructura = "Carretera";
  int _columnaEstructura = 0;
  String _elemento = "Calzada";
  int _columnaElemento = 1;
  String _dano = "Hundimiento";
  String _severidad = "Baja";
  String _servicio = "Habilitado";
  String _evento = "Lluvia";
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
  int get columnaEstructura => _columnaEstructura;
  String get elemento => _elemento;
  int get columnaElemento => _columnaElemento;
  String get dano => _dano;
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
    _severidad = "Baja";
    _servicio = "Habilitado";
    _evento = "Lluvia";
    switch (_estructura) {
      case "Carretera":
        _elemento = "Calzada";
        _columnaEstructura = 0;
        _dano = "Hundimiento";
        _columnaElemento = 1;
        break;
      case "Puente":
        _elemento = "Bastiones";
        _columnaEstructura = 1;
        _dano = "Socavación";
        _columnaElemento = 9;
        break;
      case "Alcantarilla mayor":
        _elemento = "Delantal";
        _columnaEstructura = 2;
        _dano = "Socavación";
        _columnaElemento = 17;
        break;
      case "Puente peatonal":
        _elemento = "Apoyo paso principal";
        _columnaEstructura = 3;
        _dano = "Inclinación";
        _columnaElemento = 22;
        break;
    }
    notifyListeners();
  }

  void setElemento(String newElemento) {
    _elemento = newElemento;
    _severidad = "Baja";
    _servicio = "Habilitado";
    _evento = "Lluvia";
    switch (_elemento) {
      case "Alcantarilla":
        _dano = "Obstrucción";
        _columnaElemento = 0;
        break;
      case "Calzada":
        _dano = "Hundimiento";
        _columnaElemento = 1;
        break;
      case "Cuneta":
        _dano = "Excede la capacidad";
        _columnaElemento = 2;
        break;
      case "Contracuneta":
        _dano = "Colapso";
        _columnaElemento = 3;
        break;
      case "Muro":
        _dano = "Agrietamiento";
        _columnaElemento = 4;
        break;
      case "Relleno":
        _dano = "Asentamiento";
        _columnaElemento = 5;
        break;
      case "Talud":
        _dano = "Derrumbe";
        _columnaElemento = 6;
        break;
      case "Vado":
        _dano = "Erosión (grada)";
        _columnaElemento = 7;
        break;
      case "Apoyos":
        _dano = "Deformación";
        _columnaElemento = 8;
        break;
      case "Bastiones":
        _dano = "Socavación";
        _columnaElemento = 9;
        break;
      case "Elementos de protección":
        _dano = "Agrietamiento";
        _columnaElemento = 10;
        break;
      case "Márgenes":
        _dano = "Modificación del cauce";
        _columnaElemento = 11;
        break;
      case "Pilas":
        _dano = "Socavación";
        _columnaElemento = 12;
        break;
      case "Relleno de aproximación":
        _dano = "Hundimiento";
        _columnaElemento = 13;
        break;
      case "Superestructura":
        _dano = "Falla de elemento de acero";
        _columnaElemento = 14;
        break;
      case "Pasarela peatonal":
        _dano = "Agrietamiento estructural";
        _columnaElemento = 15;
        break;
      case "Aletones":
        _dano = "Acumulación de escombros";
        _columnaElemento = 16;
        break;
      case "Delantal":
        _dano = "Socavación";
        _columnaElemento = 17;
        break;
      case "Rellenos":
        _dano = "Pérdida parcial del relleno";
        _columnaElemento = 18;
        break;
      case "Estructura principal":
        _dano = "Deformación (acero)";
        _columnaElemento = 19;
        break;
      case "Accesos":
        _dano = "Colapso";
        _columnaElemento = 20;
        break;
      case "Súper-estructura":
        _dano = "Desplazamiento";
        _columnaElemento = 21;
        break;
      case "Apoyo paso principal":
        _dano = "Inclinación";
        _columnaElemento = 22;
        break;
      case "Apoyos intermedios":
        _dano = "Agrietamiento estructural";
        _columnaElemento = 23;
        break;
    }
    notifyListeners();
  }

  void setDano(String newDano) {
    _dano = newDano;
    _severidad = "Baja";
    _servicio = "Habilitado";
    _evento = "Lluvia";
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
