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
    }
    notifyListeners();
  }
}
