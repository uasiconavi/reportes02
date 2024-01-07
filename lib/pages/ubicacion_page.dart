import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../components/components.dart';

class UbicacionPage extends StatefulWidget {
  const UbicacionPage({Key? key}) : super(key: key);

  @override
  State<UbicacionPage> createState() => _UbicacionPageState();
}

class _UbicacionPageState extends State<UbicacionPage> {
  bool buscando = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Encabezado(),
        SizedBox(
          height: 438.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Ubicación:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              context.watch<ReportProvider>().ubicacion != null
                  ? const VerUbicacion()
                  : const Text("Sin datos"),
              buscando == true
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          buscando = true;
                        });
                        final position = await _obtenerUbicacion();
                        setState(() {
                          buscando = false;
                          context.read<ReportProvider>().setUbicacion(position);
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text("Coordenadas"),
                          SizedBox(width: 5.0),
                          Icon(Icons.gps_fixed),
                        ],
                      ),
                    ),
              context.watch<ReportProvider>().ubicacion != null
                  ? const BotonSiguiente()
                  : const Text(
                      "Debe activar los servicios de ubicación y mantenerse en un punto fijo para obtener sus coordenadas.",
                      textAlign: TextAlign.center,
                    ),
              const Text(
                'De aquí en adelante se requiere conexión a Internet',
                style: TextStyle(
                  fontSize: 14.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<Position> _obtenerUbicacion() async {
    bool servicioHabilitado;
    LocationPermission permiso;

    servicioHabilitado = await Geolocator.isLocationServiceEnabled();
    if (!servicioHabilitado) {
      setState(() {
        buscando = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Habilite los servicios de ubicación"),
          ),
        );
      });
      return Future.error('Los servicios están deshabilitados');
    }

    permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
      if (permiso == LocationPermission.denied) {
        setState(() {
          buscando = false;
        });
        return Future.error('Los permisos están denegados');
      }
    }

    if (permiso == LocationPermission.deniedForever) {
      setState(() {
        buscando = false;
      });
      return Future.error(
          'Los permisos están permanentemente denegados, no se pueden solicitar');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
