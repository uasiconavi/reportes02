import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../components/components.dart';

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
            context.watch<ReportProvider>().guardando == true
                ? const IndicadorGuardando()
                : const BotonGuardando(),
          ],
        ),
      ],
    );
  }
}
