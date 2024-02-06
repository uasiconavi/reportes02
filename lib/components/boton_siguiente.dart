import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';

class BotonSiguiente extends StatefulWidget {
  const BotonSiguiente({Key? key}) : super(key: key);

  @override
  State<BotonSiguiente> createState() => _BotonSiguienteState();
}

class _BotonSiguienteState extends State<BotonSiguiente> {
  bool _buttonEnabled = true;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_buttonEnabled) {
          context.read<PaginationProvider>().nextPage();
          context.read<PaginationProvider>().setTitulo();
          setState(() {
            _buttonEnabled = false;
          });
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text("Siguiente"),
          SizedBox(width: 5.0),
          Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}
