/* import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../components/components.dart';

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
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 75.0),
                    child: muestraFotos(context),
                  )
                : const SizedBox(
                    height: 175.0,
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                    onPressed: cantFotos < 10 ? _tomar : _mensajeMax,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Cámara')),
              ],
            ),
            cantFotos > 1
                ? const Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child: BotonSiguiente(),
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
}
 */