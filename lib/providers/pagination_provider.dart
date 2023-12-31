import 'package:flutter/material.dart';
import 'package:reportes02/pages/observaciones_page.dart';
import 'package:reportes02/pages/seccion_page.dart';
import 'package:reportes02/pages/ubicacion_page.dart';
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
    const ZonaPage(),
    const RutaPage(),
    const SeccionPage(),
    const UbicacionPage(),
    const ObservacionesPage(),
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
      case 7:
        _titulo = "Zona";
        break;
      case 8:
        _titulo = "Ruta";
        break;
      case 9:
        _titulo = "Sección";
        break;
      case 10:
        _titulo = "Ubicación";
        break;
      case 11:
        _titulo = "Observaciones";
        break;
    }
    notifyListeners();
  }
}
