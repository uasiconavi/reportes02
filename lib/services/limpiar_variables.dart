import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';

void limpiarVariables(BuildContext context) {
  context.read<ReportProvider>().clearFotos();
  context.read<ReportProvider>().setPrimeraVezEstructura(true);
  context.read<ReportProvider>().setEstructura("Carretera");
  context.read<ReportProvider>().setPrimeraVezElemento(true);
  context.read<ReportProvider>().setSeveridad("Baja");
  context.read<ReportProvider>().setServicio("Habilitado");
  context.read<ReportProvider>().setEvento("Lluvia");
  context.read<ReportProvider>().setFechaEvento(
      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
  context.read<ReportProvider>().setPrimeraVezZona(true);
  context.read<ReportProvider>().setZona("1-1 San José");
  context.read<ReportProvider>().setPrimeraVezRuta(true);
  context.read<ReportProvider>().setUbicacion(null);
  context.read<ReportProvider>().setObservaciones("");
  context.read<PaginationProvider>().iniciarPage();
}
