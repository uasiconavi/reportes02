import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> subirFotos(
    int cantFotos, List<String> nombresImagen, List<File> fotos) async {
  /* await FirebaseFirestore.instance
        .collection("bloqueos")
        .doc("bloqueado")
        .update({
      "locked": true,
    }); */
  for (var i = 0; i <= cantFotos; i++) {
    try {
      //String rutaImagen = '$usuario/$nombresImagen[i]';
      String rutaImagen = nombresImagen[i];
      await FirebaseStorage.instance.ref().child(rutaImagen).putFile(
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
