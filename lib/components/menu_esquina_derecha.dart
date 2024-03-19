import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../pages/pages.dart';
import 'package:reportes02/main.dart';
import '../services/services.dart';
import 'package:badges/badges.dart';

class MenuEsquinaDerecha extends StatefulWidget {
  const MenuEsquinaDerecha({Key? key}) : super(key: key);

  @override
  State<MenuEsquinaDerecha> createState() => _MenuEsquinaDerechaState();
}

class _MenuEsquinaDerechaState extends State<MenuEsquinaDerecha> {
  List<Reporte> reportes = [];
  @override
  Widget build(BuildContext context) {
    String usuario = context.watch<ReportProvider>().usuario;
    cargaReportes();
    List<String> menu = [
      usuario,
      "Cerrar sesión",
      "Reportes pendientes  (${reportes.length})",
    ];
    return Badge(
      showBadge: reportes.isEmpty ? false : true,
      badgeContent: Text(reportes.length.toString()),
      position: BadgePosition.topStart(),
      badgeStyle: const BadgeStyle(badgeColor: Color(0xFFFDC300)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
            value: usuario,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 10.5,
            ),
            items: menu.map((String item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (String? nuevoValor) {
              if (nuevoValor == "Cerrar sesión") {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("¿Desea cerrar la sesión?"),
                    actions: [
                      TextButton(
                        onPressed: signOut,
                        child: const Text(
                          "Sí",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "No",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (nuevoValor == "Reportes pendientes") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReportesPendientesPage()));
              }
            }),
      ),
    );
  }

  cargaReportes() async {
    List<Reporte> auxReportes = await DB.reportes();
    setState(() {
      reportes = auxReportes;
    });
  }

  Future signOut() async {
    FirebaseAuth.instance.signOut().then((value) {
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    });
  }
}
