import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../services/services.dart';
import 'package:flutter/services.dart';
//import 'package:geolocator/geolocator.dart';

List<String> nombresFoto = [];
List<String> listaUrl = [];
String id = "";

class BotonGuardar extends StatefulWidget {
  const BotonGuardar({Key? key}) : super(key: key);

  @override
  State<BotonGuardar> createState() => _BotonGuardarState();
}

class _BotonGuardarState extends State<BotonGuardar> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.cloud_upload_outlined),
          SizedBox(width: 5.0),
          Text("Guardar"),
        ],
      ),
      onPressed: () async {
        context.read<ReportProvider>().setGuardando(true);
        subirFotos();
      },
    );
  }

  Future<void> subirFotos() async {
    int cantReportesHoy = 0;
    bool fotosOptimizadas = false;
    String usuario =
        Provider.of<ReportProvider>(context, listen: false).usuario;
    List<File> fotos =
        Provider.of<ReportProvider>(context, listen: false).fotos;
    String estructura =
        Provider.of<ReportProvider>(context, listen: false).estructura;
    DocumentReference documento =
        FirebaseFirestore.instance //Para nombrar fotos
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
          await FirebaseStorage.instance
              .ref()
              .child(nombresFoto[i - 1])
              .putFile(
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
      if (fotosOptimizadas) {
        reporteFirestore(estructura);
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

  Future<void> reporteFirestore(String estructura) async {
    FirebaseFirestore.instance.collection("reportes").doc(id).set({
      'fecha_reporte': DateTime.now(),
      'fotos': listaUrl,
      'estructura': estructura,
      /* 'elemento': elemento,
      'dano': dano,
      'severidad': severidad,
      'servicio': servicio,
      'evento': evento,
      'fecha_evento': fecha,
      'zona': zona,
      'ruta': ruta,
      'seccion': seccion,
      'ubicacion': GeoPoint(ubicacion!.latitude, ubicacion.longitude),
      'observaciones': observaciones, */
    }).then((value) {
      context.read<ReportProvider>().setGuardando(false);
      //_mensajeCierreApp(context);
    });
  }

  _mensajeCierreApp(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black54,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("¿Desea realizar otro reporte?"),
        actions: [
          TextButton(
            child: const Text(
              "Sí",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              limpiarVariables(context);
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text(
              "No (salir)",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
        ],
      ),
    );
  }
}
