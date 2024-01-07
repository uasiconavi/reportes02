import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import 'dart:io';

class MostrarFotos extends StatelessWidget {
  const MostrarFotos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int cantFotos = context.watch<ReportProvider>().fotos.length;
    List<File> fotos = context.watch<ReportProvider>().fotos;

    if (cantFotos == 1) {
      return recuadroFoto(fotos[0]);
    }
    if (cantFotos == 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          recuadroFoto(fotos[0]),
          recuadroFoto(fotos[1]),
        ],
      );
    }
    if (cantFotos == 3) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          recuadroFoto(fotos[0]),
          recuadroFoto(fotos[1]),
          recuadroFoto(fotos[2]),
        ],
      );
    }
    if (cantFotos == 4) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          recuadroFoto(fotos[0]),
          recuadroFoto(fotos[1]),
          recuadroFoto(fotos[2]),
          recuadroFoto(fotos[3]),
        ],
      );
    }
    if (cantFotos == 5) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              recuadroFoto(fotos[0]),
              recuadroFoto(fotos[1]),
              recuadroFoto(fotos[2]),
              recuadroFoto(fotos[3]),
            ],
          ),
          const SizedBox(height: 2.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              recuadroFoto(fotos[4]),
              const SizedBox(height: 100.0, width: 80.0),
              const SizedBox(height: 100.0, width: 80.0),
              const SizedBox(height: 100.0, width: 80.0),
            ],
          ),
        ],
      );
    }
    if (cantFotos == 6) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              recuadroFoto(fotos[0]),
              recuadroFoto(fotos[1]),
              recuadroFoto(fotos[2]),
              recuadroFoto(fotos[3]),
            ],
          ),
          const SizedBox(height: 2.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              recuadroFoto(fotos[4]),
              recuadroFoto(fotos[5]),
              const SizedBox(height: 100.0, width: 80.0),
              const SizedBox(height: 100.0, width: 80.0),
            ],
          ),
        ],
      );
    }
    if (cantFotos == 7) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              recuadroFoto(fotos[0]),
              recuadroFoto(fotos[1]),
              recuadroFoto(fotos[2]),
              recuadroFoto(fotos[3]),
            ],
          ),
          const SizedBox(height: 2.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              recuadroFoto(fotos[4]),
              recuadroFoto(fotos[5]),
              recuadroFoto(fotos[6]),
              const SizedBox(height: 100.0, width: 80.0),
            ],
          ),
        ],
      );
    }
    if (cantFotos == 8) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              recuadroFoto(fotos[0]),
              recuadroFoto(fotos[1]),
              recuadroFoto(fotos[2]),
              recuadroFoto(fotos[3]),
            ],
          ),
          const SizedBox(height: 2.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              recuadroFoto(fotos[4]),
              recuadroFoto(fotos[5]),
              recuadroFoto(fotos[6]),
              recuadroFoto(fotos[7]),
            ],
          ),
        ],
      );
    }
    if (cantFotos == 9) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              recuadroFoto(fotos[0]),
              recuadroFoto(fotos[1]),
              recuadroFoto(fotos[2]),
              recuadroFoto(fotos[3]),
            ],
          ),
          const SizedBox(height: 2.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              recuadroFoto(fotos[4]),
              recuadroFoto(fotos[5]),
              recuadroFoto(fotos[6]),
              recuadroFoto(fotos[7]),
            ],
          ),
          const SizedBox(height: 2.0),
          recuadroFoto(fotos[8]),
        ],
      );
    }
    if (cantFotos == 10) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              recuadroFoto(fotos[0]),
              recuadroFoto(fotos[1]),
              recuadroFoto(fotos[2]),
              recuadroFoto(fotos[3]),
            ],
          ),
          const SizedBox(height: 2.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              recuadroFoto(fotos[4]),
              recuadroFoto(fotos[5]),
              recuadroFoto(fotos[6]),
              recuadroFoto(fotos[7]),
            ],
          ),
          const SizedBox(height: 2.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              recuadroFoto(fotos[8]),
              recuadroFoto(fotos[9]),
            ],
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}

Widget recuadroFoto(File imagen) {
  return Image.file(
    imagen,
    height: 100.0,
    width: 80.0,
  );
}
