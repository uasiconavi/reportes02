import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> subirFotos(int cantFotos, fecha, List<File> fotos) async {
  /* await FirebaseFirestore.instance
        .collection("bloqueos")
        .doc("bloqueado")
        .update({
      "locked": true,
    }); */
  for (var i = 0; i < cantFotos; i++) {
    try {
      //String rutaFoto = '$usuario/$nombresFotos[i]';
      //String rutaFoto = nombresFotos[i];
      await FirebaseStorage.instance.ref().child('$fecha-$i').putFile(
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
