import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../components/components.dart';

class DanoPage extends StatefulWidget {
  const DanoPage({super.key});

  @override
  State<DanoPage> createState() => _DanoPageState();
}

class _DanoPageState extends State<DanoPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        encabezadoDano(context),
        SizedBox(
          height: 556.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Tipo de daño de "${context.watch<ReportProvider>().elemento}":',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black87,
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.circular(9.0)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black87,
                    ),
                    iconSize: 40.0,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    borderRadius: BorderRadius.circular(9.0),
                    elevation: 3,
                    iconEnabledColor: Colors.blueGrey,
                    iconDisabledColor: Colors.white,
                    isExpanded: true,
                    isDense: true,
                    value: context.watch<ReportProvider>().dano,
                    items: context
                        .watch<ReportProvider>()
                        .listaDanos
                        .map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? nuevoValor) {
                      context.read<ReportProvider>().setDano(nuevoValor!);
                      context
                          .read<ReportProvider>()
                          .setPrimeraVezElemento(false);
                      context.read<ReportProvider>().setSeveridad("Baja");
                      context.read<ReportProvider>().setServicio("Habilitado");
                      context.read<ReportProvider>().setEvento("Lluvia");
                    },
                  ),
                ),
              ),
              const BotonSiguiente(),
            ],
          ),
        ),
      ],
    );
  }
}

Widget encabezadoDano(BuildContext context) {
  return Container(
    margin: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Estructura: ',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                )),
            Text(context.watch<ReportProvider>().estructura,
                style: const TextStyle(
                  fontSize: 12.0,
                )),
          ],
        ),
        Row(
          children: [
            const Text('Elemento:  ',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                )),
            Text(context.watch<ReportProvider>().elemento,
                style: const TextStyle(
                  fontSize: 12.0,
                )),
          ],
        ),
      ],
    ),
  );
}
