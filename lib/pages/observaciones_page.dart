import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../services/services.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

bool guardando = false;
List<String> nombresFoto = [];
List<String> listaUrl = [];
String idRep = "";
String fechaReporte =
    "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";

class ObservacionesPage extends StatefulWidget {
  const ObservacionesPage({Key? key}) : super(key: key);

  @override
  State<ObservacionesPage> createState() => _ObservacionesPageState();
}

class _ObservacionesPageState extends State<ObservacionesPage> {
  TextEditingController observacionesController =
      TextEditingController(text: "");
  int longCaracteres = 254;
  List<Reporte> reportes = [];
  bool conexion = false;
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
          guardar(context);
          //subirFotos(context);
        });
      },
    );
  }

  guardar(BuildContext context) {
    // Obtiene la lista de fotos del provider
    List<File>? fotos =
        Provider.of<ReportProvider>(context, listen: false).fotos;

    // Crea un nuevo objeto Reporte con todos los datos necesarios
    Reporte nuevoReporte = Reporte(
      fechaReporte: fechaReporte,
      estructura:
          Provider.of<ReportProvider>(context, listen: false).estructura,
      elemento: Provider.of<ReportProvider>(context, listen: false).elemento,
      dano: Provider.of<ReportProvider>(context, listen: false).dano,
      severidad: Provider.of<ReportProvider>(context, listen: false).severidad,
      servicio: Provider.of<ReportProvider>(context, listen: false).servicio,
      evento: Provider.of<ReportProvider>(context, listen: false).evento,
      fechaEvento:
          Provider.of<ReportProvider>(context, listen: false).fechaEvento,
      zona: Provider.of<ReportProvider>(context, listen: false).zona,
      ruta: Provider.of<ReportProvider>(context, listen: false).ruta,
      seccion: Provider.of<ReportProvider>(context, listen: false).seccion,
      latitud: Provider.of<ReportProvider>(context, listen: false)
          .ubicacion!
          .latitude,
      longitud: Provider.of<ReportProvider>(context, listen: false)
          .ubicacion!
          .longitude,
      observaciones:
          Provider.of<ReportProvider>(context, listen: false).observaciones,
    );

    DB.insert(fotos, nuevoReporte).then((value) async {
      conexion = await comprobarInternet();
    }).then((value) {
      if (conexion == true) {
        subirFotos(context);
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
                "Reporte pendiente de subir a la nube por falta de conexión"),
            actions: [
              TextButton(
                onPressed: () {
                  mensajeCierreApp(context);
                },
                child: const Text(
                  "Aceptar",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ).then((value) {
          mensajeCierreApp(context);
        });
      }
    });
  }

  Future<bool> comprobarInternet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  Future<void> subirFotos(BuildContext context) async {
    int cantReportes = 0;
    bool fotosOptimizadas = false;
    String usuario =
        Provider.of<ReportProvider>(context, listen: false).usuario;
    List<File> fotos =
        Provider.of<ReportProvider>(context, listen: false).fotos;
    DocumentReference documento =
        FirebaseFirestore.instance.collection(usuario).doc(fechaReporte);
    documento.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        //Para cuando el documento ya existe, se actualiza
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        if (data.containsKey('cantReportes')) {
          cantReportes = data['cantReportes'];
          cantReportes++;
          documento.update({
            'cantReportes': cantReportes,
          });
        }
      } else {
        //Para cuando el documento no existe, se crea
        cantReportes = 1;
        CollectionReference collection =
            FirebaseFirestore.instance.collection(usuario);
        collection.doc(fechaReporte).set({
          'cantReportes': cantReportes,
        });
      }
    }).then((value) async {
      idRep = '${fechaReporte}_${usuario.split('@').first}_rep-$cantReportes';
      nombresFoto.clear();
      for (var i = 1; i <= fotos.length; i++) {
        try {
          nombresFoto.add('$usuario/${idRep}_$i.jpeg');
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
    FirebaseFirestore.instance.collection("reportes").doc(idRep).set({
      'fecha_reporte': fechaReporte,
      'fotos': listaUrl,
      'estructura':
          Provider.of<ReportProvider>(context, listen: false).estructura,
      'elemento': Provider.of<ReportProvider>(context, listen: false).elemento,
      'dano': Provider.of<ReportProvider>(context, listen: false).dano,
      'severidad':
          Provider.of<ReportProvider>(context, listen: false).severidad,
      'servicio': Provider.of<ReportProvider>(context, listen: false).servicio,
      'evento': Provider.of<ReportProvider>(context, listen: false).evento,
      'fecha_evento':
          Provider.of<ReportProvider>(context, listen: false).fechaEvento,
      'zona': Provider.of<ReportProvider>(context, listen: false).zona,
      'ruta':
          int.parse(Provider.of<ReportProvider>(context, listen: false).ruta),
      'seccion': int.parse(
          Provider.of<ReportProvider>(context, listen: false).seccion),
      'ubicacion': GeoPoint(ubicacion!.latitude, ubicacion.longitude),
      'observaciones':
          Provider.of<ReportProvider>(context, listen: false).observaciones,
    }).then((value) {
      eliminarUltimoReporte();
      mensajeCierreApp(context);
    });
  }

  mensajeCierreApp(BuildContext context) {
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

  eliminarUltimoReporte() async {
    if (conexion) {
      await cargaReportes();
      DB.delete(reportes.last);
    }
  }

  cargaReportes() async {
    List<Reporte> auxReportes = await DB.reportes();
    setState(() {
      reportes = auxReportes;
    });
  }
}
