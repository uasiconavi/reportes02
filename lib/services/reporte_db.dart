import 'package:geolocator/geolocator.dart';

class Reporte {
  int? id;
  final String? fechaReporte;
  final String? estructura;
  final String? elemento;
  final String? dano;
  final String? severidad;
  final String? servicio;
  final String? evento;
  final String? fechaEvento;
  final String? zona;
  final String? ruta;
  final String? seccion;
  final Position? ubicacion;
  final String? observaciones;

  Reporte(
      {this.id,
      this.fechaReporte,
      this.estructura,
      this.elemento,
      this.dano,
      this.severidad,
      this.servicio,
      this.evento,
      this.fechaEvento,
      this.zona,
      this.ruta,
      this.seccion,
      this.ubicacion,
      this.observaciones});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fecha_reporte': fechaReporte,
      'estructura': estructura,
      'elemento': elemento,
      'dano': dano,
      'severidad': severidad,
      'servicio': servicio,
      'evento': evento,
      'fecha_evento': fechaEvento,
      'zona': zona,
      'ruta': ruta,
      'seccion': seccion,
      'ubicacion': ubicacion,
      'observaciones': observaciones,
    };
  }
}
