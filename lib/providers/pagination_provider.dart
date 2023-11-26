import 'package:flutter/material.dart';
import '../pages/pages.dart';

class PaginationProvider with ChangeNotifier {
  int _currentPage = 0;

  final List<Widget> _pages = [
    const EstructuraPage(),
  ];

  Widget get currentPage => _pages[_currentPage];

  void nextPage() {
    _currentPage++;
    notifyListeners();
  }

  void previousPage() {
    _currentPage--;
    notifyListeners();
  }
}
