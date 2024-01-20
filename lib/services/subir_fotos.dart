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
  String fechaUltimoReporte = "";
  DocumentReference documento = FirebaseFirestore.instance
      .collection('contadorReportesUsuario')
      .doc(usuario);
  documento.get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('fechaUltimoReporte')) {
        fechaUltimoReporte = data['fechaUltimoReporte'];
        if (fechaUltimoReporte ==
            '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}') {
          print("El último reporte fue hoy");
        } else {
          print("El último reporte no fue hoy");
        }
      }
    } else {
      print("El documento no existe, así que lo estoy creando");
      CollectionReference collection =
          FirebaseFirestore.instance.collection('contadorReportesUsuario');
      collection.doc(usuario).set({
        'fechaUltimoReporte':
            '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}'
      });
    }
  });
  for (var i = 0; i < cantFotos; i++) {
    try {
      await FirebaseStorage.instance
          .ref()
          .child(
              '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}_')
          .putFile(
            fotos[i],
            /* SettableMetadata(customMetadata: {
            'autor': usuario,
          }) */
          );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  //getListaUrl();
}
