import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reportes02/components/mostrar_fotos.dart';
import '../providers/providers.dart';
import '../components/components.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FotosPage extends StatefulWidget {
  const FotosPage({super.key});

  @override
  State<FotosPage> createState() => _FotosPageState();
}

class _FotosPageState extends State<FotosPage> {
  @override
  Widget build(BuildContext context) {
    int cantFotos = context.watch<ReportProvider>().fotos.length;
    return ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Cantidad de fotos: ',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '$cantFotos',
                    style: const TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            cantFotos > 0
                ? const Padding(
                    padding: EdgeInsets.only(bottom: 75.0),
                    child: MostrarFotos(),
                  )
                : const SizedBox(
                    height: 175.0,
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Cámara'),
                  onPressed: cantFotos < 10 ? _tomar : _mensajeMax,
                ),
              ],
            ),
            cantFotos > 1
                ? Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton.icon(
                              icon: const Icon(Icons.restart_alt),
                              label: const Text('Reiniciar'),
                              onPressed:
                                  context.read<ReportProvider>().clearFotos,
                            ),
                            const BotonSiguiente(),
                          ],
                        ),
                      ],
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Text(
                      "Debe tomar entre 2 y 10 fotos para realizar el reporte del daño.",
                      style: TextStyle(fontSize: 13.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
          ],
        ),
      ],
    );
  }

  Future<void> _tomar() async {
    final foto = await ImagePicker().pickImage(source: ImageSource.camera);
    if (foto != null) {
      setState(() {
        context.read<ReportProvider>().addFoto(File(foto.path));
      });
    }
  }

  void _mensajeMax() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("No puede guardar más de 10 fotos"),
      ),
    );
  }
}
