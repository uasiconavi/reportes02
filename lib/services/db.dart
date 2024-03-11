import 'dart:io';
import 'reporte_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'reportes.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE reportes (id INTEGER PRIMARY KEY AUTOINCREMENT, fotos TEXT, fecha_reporte TEXT, estructura TEXT, elemento TEXT, dano TEXT, severidad TEXT, servicio TEXT, evento TEXT, fecha_evento TEXT, zona TEXT, ruta TEXT, seccion TEXT, latitud REAL, longitud REAL, observaciones TEXT)",
      );
    }, version: 1);
  }

  static Future insert(List<File>? fotos, Reporte reporte) async {
    // Convierte la lista de archivos en una lista de rutas de fotos.
    final List<String>? fotosPaths = fotos?.map((foto) => foto.path).toList();

    Database database = await _openDB();

    // Crea un nuevo mapa que incluye las rutas de las fotos.
    Map<String, dynamic> reporteMap = reporte.toMap();

    // Añade las rutas de las fotos al mapa.
    reporteMap['fotos'] = fotosPaths?.join(',');

    // Inserta el nuevo mapa en la base de datos.
    return database.insert("reportes", reporteMap);
  }

  static Future delete(Reporte reporte) async {
    Database database = await _openDB();

    return database
        .delete("reportes", where: "id = ?", whereArgs: [reporte.id]);
  }

  static Future<List<Reporte>> reportes() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> reportesMap =
        await database.query("reportes");

    return List.generate(
        reportesMap.length,
        (i) => Reporte(
              id: reportesMap[i]['id'],
              fechaReporte: reportesMap[i]['fecha_reporte'],
              fotos: (reportesMap[i]['fotos'] as String)
                  .split(',')
                  .map((path) => File(path))
                  .toList(),
              estructura: reportesMap[i]['estructura'],
              elemento: reportesMap[i]['elemento'],
              dano: reportesMap[i]['dano'],
              severidad: reportesMap[i]['severidad'],
              servicio: reportesMap[i]['servicio'],
              evento: reportesMap[i]['evento'],
              fechaEvento: reportesMap[i]['fecha_evento'],
              zona: reportesMap[i]['zona'],
              ruta: reportesMap[i]['ruta'],
              seccion: reportesMap[i]['seccion'],
              latitud: reportesMap[i]['latitud'],
              longitud: reportesMap[i]['longitud'],
              observaciones: reportesMap[i]['observaciones'],
            ));
  }

  static Future<void> eliminarBaseDeDatos() async {
    final path = join(await getDatabasesPath(), 'reportes.db');
    Database database = await _openDB();
    await database.close();
    await deleteDatabase(path);
  }
}
