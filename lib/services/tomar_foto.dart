import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<File?> tomarFoto() async {
  final foto = await ImagePicker().pickImage(source: ImageSource.camera);
  if (foto == null) return null;

  return File(foto.path);
}
