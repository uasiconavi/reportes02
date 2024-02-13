import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../components/components.dart';
import '../services/services.dart';

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
        SizedBox(
          height: 500.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
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
              cantFotos > 0 ? const MostrarFotos() : const SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Cámara'),
                    onPressed: cantFotos < 10
                        ? () async {
                            tomarFoto().then((foto) {
                              if (foto != null) {
                                context.read<ReportProvider>().addFoto(foto);
                              }
                            });
                          }
                        : _mensajeMax,
                  ),
                ],
              ),
            ],
          ),
        ),
        cantFotos > 1
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                      icon: const Icon(Icons.restart_alt),
                      label: const Text('Reiniciar'),
                      onPressed: () {
                        limpiarVariables(context);
                      }),
                  const BotonSiguiente(),
                ],
              )
            : const Text(
                "Debe tomar entre 2 y 10 fotos para realizar el reporte del daño.",
                style: TextStyle(fontSize: 13.0),
                textAlign: TextAlign.center,
              ),
      ],
    );
  }

  void _mensajeMax() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("No puede guardar más de 10 fotos"),
      ),
    );
  }
}
