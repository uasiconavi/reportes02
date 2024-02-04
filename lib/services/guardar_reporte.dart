import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';

List<String> nombresFoto = [];
List<String> listaUrl = [];
String id = "";
bool fotosOptimizadas = false;

Future<void> guardarReporte(
  String usuario,
  List<File> fotos,
  String estructura,
  String elemento,
  String dano,
  String severidad,
  String servicio,
  String evento,
  String fecha,
  String zona,
  String ruta,
  String seccion,
  Position? ubicacion,
  String observaciones,
) async {
  int cantReportesHoy = 0;
  DocumentReference documento = FirebaseFirestore.instance //Para nombrar fotos
      .collection('contadorReportesUsuario')
      .doc(usuario);
  documento.get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('fechaUltimoReporte') &&
          data.containsKey('cantReportesHoy')) {
        cantReportesHoy = data['cantReportesHoy'];
        if (data['fechaUltimoReporte'] ==
            '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}') {
          //Para cuando el último reporte fue hoy
          cantReportesHoy++;
        } else {
          //Para cuando el último reporte no fue hoy
          cantReportesHoy = 1;
        }
        documento.update({
          'cantReportesHoy': cantReportesHoy,
          'fechaUltimoReporte':
              '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}'
        });
      }
    } else {
      //Para cuando el documento no existe, se crea
      CollectionReference collection =
          FirebaseFirestore.instance.collection('contadorReportesUsuario');
      collection.doc(usuario).set({
        'fechaUltimoReporte':
            '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
        'cantReportesHoy': 1,
      });
      cantReportesHoy = 1;
    }
  }).then((value) async {
    id =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}_${usuario.split('@').first}_rep-$cantReportesHoy';
    nombresFoto.clear();
    for (var i = 1; i <= fotos.length; i++) {
      try {
        nombresFoto.add('$usuario/${id}_$i.jpeg');
        await FirebaseStorage.instance.ref().child(nombresFoto[i - 1]).putFile(
            fotos[i - 1],
            SettableMetadata(customMetadata: {
              'autor': usuario,
            }));
        // ignore: empty_catches
      } catch (e) {}
    }
  }).then((value) async {
    while (!fotosOptimizadas) {
      try {
        listaUrl = await getUrlFotos(fotos.length);
        fotosOptimizadas = true;
        // ignore: empty_catches
      } catch (e) {}
    }
    if (fotosOptimizadas == true) {
      reporteFirestore(
        id,
        listaUrl,
        estructura,
        elemento,
        dano,
        severidad,
        servicio,
        evento,
        fecha,
        zona,
        ruta,
        seccion,
        ubicacion,
        observaciones,
      );
    }
  });
}

Future<List<String>> getUrlFotos(int cantFotos) async {
  List<String> urlFotos = [];
  for (var i = 0; i < cantFotos; i++) {
    String nombreFotoOptimizada =
        '${nombresFoto[i].split('.jpeg').first}_900x900.jpeg';
    var fotoOptimizada = FirebaseStorage.instance.ref(nombreFotoOptimizada);
    String urlFoto = await fotoOptimizada.getDownloadURL();
    urlFotos.add(urlFoto.split('&').first);
  }
  return urlFotos;
}

Future<void> reporteFirestore(
  String id,
  List<String> listaUrl,
  String estructura,
  String elemento,
  String dano,
  String severidad,
  String servicio,
  String evento,
  String fecha,
  String zona,
  String ruta,
  String seccion,
  Position? ubicacion,
  String observaciones,
) async {
  FirebaseFirestore.instance.collection("reportes").doc(id).set({
    'fecha_reporte': DateTime.now(),
    'fotos': listaUrl,
    'estructura': estructura,
    'elemento': elemento,
    'dano': dano,
    'severidad': severidad,
    'servicio': servicio,
    'evento': evento,
    'fecha_evento': fecha,
    'zona': zona,
    'ruta': ruta,
    'seccion': seccion,
    'ubicacion': GeoPoint(ubicacion!.latitude, ubicacion.longitude),
    'observaciones': observaciones,
  });
}
