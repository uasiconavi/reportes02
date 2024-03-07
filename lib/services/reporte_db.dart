import 'dart:io';

class Reporte {
  int? id;
  final String? fechaReporte;
  List<File>? fotos;
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
  final double? latitud;
  final double? longitud;
  final String? observaciones;

  Reporte(
      {this.id,
      this.fechaReporte,
      this.fotos,
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
      this.latitud,
      this.longitud,
      this.observaciones});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fecha_reporte': fechaReporte,
      'fotos': fotos?.map((foto) => foto.path).toList(),
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
      'latitud': latitud,
      'longitud': longitud,
      'observaciones': observaciones,
    };
  }
}
