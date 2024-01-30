String getEnlacesVisor(int cantFotos, List<String> listaUrl) {
  if (cantFotos == 2) {
    return '${listaUrl[0]}<p></p>${listaUrl[1]}';
  }
  if (cantFotos == 3) {
    return '${listaUrl[0]}<p></p>${listaUrl[1]}<p></p>${listaUrl[2]}';
  }
  if (cantFotos == 4) {
    return '${listaUrl[0]}<p></p>${listaUrl[1]}<p></p>${listaUrl[2]}<p></p>${listaUrl[3]}';
  }
  if (cantFotos == 5) {
    return '${listaUrl[0]}<p></p>${listaUrl[1]}<p></p>${listaUrl[2]}<p></p>${listaUrl[3]}<p></p>${listaUrl[4]}';
  }
  if (cantFotos == 6) {
    return '${listaUrl[0]}<p></p>${listaUrl[1]}<p></p>${listaUrl[2]}<p></p>${listaUrl[3]}<p></p>${listaUrl[4]}<p></p>${listaUrl[5]}';
  }
  if (cantFotos == 7) {
    return '${listaUrl[0]}<p></p>${listaUrl[1]}<p></p>${listaUrl[2]}<p></p>${listaUrl[3]}<p></p>${listaUrl[4]}<p></p>${listaUrl[5]}<p></p>${listaUrl[6]}';
  }
  if (cantFotos == 8) {
    return '${listaUrl[0]}<p></p>${listaUrl[1]}<p></p>${listaUrl[2]}<p></p>${listaUrl[3]}<p></p>${listaUrl[4]}<p></p>${listaUrl[5]}<p></p>${listaUrl[6]}<p></p>${listaUrl[7]}';
  }
  if (cantFotos == 9) {
    return '${listaUrl[0]}<p></p>${listaUrl[1]}<p></p>${listaUrl[2]}<p></p>${listaUrl[3]}<p></p>${listaUrl[4]}<p></p>${listaUrl[5]}<p></p>${listaUrl[6]}<p></p>${listaUrl[7]}<p></p>${listaUrl[8]}';
  }
  if (cantFotos == 10) {
    return '${listaUrl[0]}<p></p>${listaUrl[1]}<p></p>${listaUrl[2]}<p></p>${listaUrl[3]}<p></p>${listaUrl[4]}<p></p>${listaUrl[5]}<p></p>${listaUrl[6]}<p></p>${listaUrl[7]}<p></p>${listaUrl[8]}<p></p>${listaUrl[9]}';
  } else {
    return "";
  }
}
