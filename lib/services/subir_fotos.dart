import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> subirFotos(String usuario, int cantFotos, List<File> fotos) async {
  /* await FirebaseFirestore.instance
        .collection("bloqueos")
        .doc("bloqueado")
        .update({
      "locked": true,
    }); */
  int cantReportesHoy = 1;
  DocumentReference documento = FirebaseFirestore.instance
      .collection('contadorReportesUsuario')
      .doc(usuario);
  documento.get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('fechaUltimoReporte') &&
          data.containsKey('cantReportesHoy')) {
        if (data['fechaUltimoReporte'] ==
            '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}') {
          print("El último reporte fue hoy");
          documento.update({'cantReportesHoy': data['cantReportesHoy'] + 1});
        } else {
          print("El último reporte no fue hoy");
          documento.update({'cantReportesHoy': 1});
        }
        cantReportesHoy = data['cantReportesHoy'];
      }
    } else {
      print("El documento no existe, así que lo estoy creando");
      CollectionReference collection =
          FirebaseFirestore.instance.collection('contadorReportesUsuario');
      collection.doc(usuario).set({
        'fechaUltimoReporte':
            '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
        'cantReportesHoy': 1,
      });
    }
  });
  for (var i = 1; i <= cantFotos; i++) {
    try {
      await FirebaseStorage.instance
          .ref()
          .child(
              '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}_${usuario}_rep-${cantReportesHoy}_$i')
          .putFile(
              fotos[i - 1],
              SettableMetadata(customMetadata: {
                'autor': usuario,
              }));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  //getListaUrl();
}
