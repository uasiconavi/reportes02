import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../services/services.dart';
import 'package:flutter/services.dart';

bool guardando = false;
List<String> nombresFoto = [];
List<String> listaUrl = [];
String id = "";

class ObservacionesPage extends StatefulWidget {
  const ObservacionesPage({Key? key}) : super(key: key);

  @override
  State<ObservacionesPage> createState() => _ObservacionesPageState();
}

class _ObservacionesPageState extends State<ObservacionesPage> {
  TextEditingController observacionesController =
      TextEditingController(text: "");
  int longCaracteres = 254;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Encabezado(),
        const SizedBox(height: 10.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Observaciones y comentarios generales:',
              style: TextStyle(
                fontSize: 16.5,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(fontSize: 20.0),
                maxLength: 254,
                maxLines: 9,
                controller: observacionesController,
                onChanged: (String value) {
                  setState(() {
                    context.read<ReportProvider>().setObservaciones(value);
                    longCaracteres = 254 -
                        Provider.of<ReportProvider>(context, listen: false)
                            .observaciones
                            .length;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: "Máximo 254 caracteres",
                  helperText: "Nombre coloquial del sitio",
                  counterText: "${longCaracteres.toString()} caracter(es)",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Cantidad de fotos:  ',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      )),
                  Text('${context.watch<ReportProvider>().fotos.length}',
                      style: const TextStyle(
                        fontSize: 13.0,
                      )),
                ],
              ),
            ),
            guardando == true
                ? indicadorGuardando(context)
                : botonGuardar(context),
          ],
        ),
      ],
    );
  }

  Widget botonGuardar(BuildContext context) {
    return ElevatedButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.cloud_upload_outlined),
          SizedBox(width: 5.0),
          Text("Guardar"),
        ],
      ),
      onPressed: () {
        setState(() {
          guardando = true;
          subirFotos(context);
        });
      },
    );
  }

  Future<void> subirFotos(BuildContext context) async {
    int cantReportesHoy = 0;
    bool fotosOptimizadas = false;
    String usuario =
        Provider.of<ReportProvider>(context, listen: false).usuario;
    List<File> fotos =
        Provider.of<ReportProvider>(context, listen: false).fotos;
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
    }).then((value) {
      if (fotosOptimizadas) {
        reporteFirestore(context);
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

  Future<void> reporteFirestore(BuildContext context) async {
    var ubicacion =
        Provider.of<ReportProvider>(context, listen: false).ubicacion;
    FirebaseFirestore.instance.collection("reportes").doc(id).set({
      'fecha_reporte': DateTime.now(),
      'fotos': listaUrl,
      'estructura':
          Provider.of<ReportProvider>(context, listen: false).estructura,
      'elemento': Provider.of<ReportProvider>(context, listen: false).elemento,
      'dano': Provider.of<ReportProvider>(context, listen: false).dano,
      'severidad':
          Provider.of<ReportProvider>(context, listen: false).severidad,
      'servicio': Provider.of<ReportProvider>(context, listen: false).servicio,
      'evento': Provider.of<ReportProvider>(context, listen: false).evento,
      'fecha_evento': Provider.of<ReportProvider>(context, listen: false).fecha,
      'zona': Provider.of<ReportProvider>(context, listen: false).zona,
      'ruta':
          int.parse(Provider.of<ReportProvider>(context, listen: false).ruta),
      'seccion': int.parse(
          Provider.of<ReportProvider>(context, listen: false).seccion),
      'ubicacion': GeoPoint(ubicacion!.latitude, ubicacion.longitude),
      'observaciones':
          Provider.of<ReportProvider>(context, listen: false).observaciones,
    }).then((value) {
      _mensajeCierreApp(context);
    });
  }

  _mensajeCierreApp(BuildContext context) {
    setState(() {
      guardando = false;
    });
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
