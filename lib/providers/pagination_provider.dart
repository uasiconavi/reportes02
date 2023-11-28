import 'package:flutter/material.dart';
import 'package:reportes02/pages/elemento_page.dart';
import '../pages/pages.dart';

class PaginationProvider with ChangeNotifier {
  int _currentPage = 0;
  String _titulo = "Estructura";

  final List<Widget> _pages = [
    const EstructuraPage(),
    const ElementoPage(),
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
    }
    notifyListeners();
  }
}
