import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

List<String> nombresFoto = [];
List<String> listaUrl = [];
String id = "";

Future<void> subirFotos(String usuario, List<File> fotos) async {
  /* await FirebaseFirestore.instance
        .collection("bloqueos")
        .doc("bloqueado")
        .update({
      "locked": true,
    }); */
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
        nombresFoto.add('$usuario/${id}_rep-${cantReportesHoy}_$i.jpeg');
        await FirebaseStorage.instance.ref().child(nombresFoto[i - 1]).putFile(
            fotos[i - 1],
            SettableMetadata(customMetadata: {
              'author': usuario,
            }));
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }).then((value) {
    getListaUrl(fotos.length);
  });
}

Future<void> getListaUrl(int cantFotos) async {
  bool fotoOptimizada = false;
  while (!fotoOptimizada) {
    try {
      listaUrl = await getUrlFotos(cantFotos);
      fotoOptimizada = true;
    } catch (e) {
      debugPrint("Imágenes no optimizadas aún, intento de nuevo en 5 segundos");
    }
  }
  if (fotoOptimizada == true) {
    for (var i = 0; i < cantFotos; i++) {
      debugPrint(listaUrl[i]);
    }
    reporteFirestore();
  }
}

Future<List<String>> getUrlFotos(int cantFotos) async {
  List<String> urlFotos = [];
  for (var i = 0; i < cantFotos; i++) {
    String nombreFotoOptimizada =
        '${nombresFoto[i].split('.jpeg').first}_900x900.jpeg';
    debugPrint(nombreFotoOptimizada);
    var fotoOptimizada = FirebaseStorage.instance.ref(nombreFotoOptimizada);
    String urlFoto = await fotoOptimizada.getDownloadURL();
    urlFotos.add(urlFoto.split('&').first);
  }
  return urlFotos;
}

Future<void> reporteFirestore() async {
  FirebaseFirestore.instance.collection("reportes").add({
    'fotos': listaUrl,
  });
}
