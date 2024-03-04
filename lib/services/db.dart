import 'reporte_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'reportes.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE reportes (id INTEGER PRIMARY KEY AUTOINCREMENT, fecha_reporte TEXT, estructura TEXT, elemento TEXT, dano TEXT, severidad TEXT, servicio TEXT, evento TEXT, fecha_evento TEXT, zona TEXT, ruta TEXT, seccion TEXT, observaciones TEXT)",
      );
    }, version: 1);
  }

  static Future insert(Reporte reporte) async {
    Database database = await _openDB();

    return database.insert("reportes", reporte.toMap());
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
