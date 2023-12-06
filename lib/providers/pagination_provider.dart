import 'package:flutter/material.dart';
import '../pages/pages.dart';

class PaginationProvider with ChangeNotifier {
  int _currentPage = 0;
  String _titulo = "Estructura";

  final List<Widget> _pages = [
    const EstructuraPage(),
    const ElementoPage(),
    const DanoPage(),
    const SeveridadPage(),
    const ServicioPage(),
    const EventoPage(),
    const FechaPage(),
  ];

  Widget get currentPage => _pages[_currentPage];
  String get titulo => _titulo;

  void nextPage() {
    _currentPage++;
    notifyListeners();
  }

  void previousPage() {
    _currentPage--;
    notifyListeners();
  }

  void setTitulo() {
    switch (_currentPage) {
      case 0:
        _titulo = "Estructura";
        break;
      case 1:
        _titulo = "Elemento";
        break;
      case 2:
        _titulo = "Daño";
        break;
      case 3:
        _titulo = "Severidad";
        break;
      case 4:
        _titulo = "Servicio";
        break;
      case 5:
        _titulo = "Evento";
        break;
      case 6:
        _titulo = "Fecha";
        break;
    }
    notifyListeners();
  }
}
