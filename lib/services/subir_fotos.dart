import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

int cantReportesHoy = 0;

Future<void> subirFotos(String usuario, int cantFotos, List<File> fotos) async {
  /* await FirebaseFirestore.instance
        .collection("bloqueos")
        .doc("bloqueado")
        .update({
      "locked": true,
    }); */
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
    for (var i = 1; i <= cantFotos; i++) {
      try {
        await FirebaseStorage.instance
            .ref()
            .child(
                '$usuario/${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}_${usuario.split('@').first}_rep-${cantReportesHoy}_$i.jpeg')
            .putFile(
                fotos[i - 1],
                SettableMetadata(customMetadata: {
                  'author': usuario,
                }));
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  });

  //getListaUrl();
}
