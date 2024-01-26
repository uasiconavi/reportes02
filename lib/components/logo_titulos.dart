import 'package:flutter/material.dart';

class LogoTitulos extends StatelessWidget {
  const LogoTitulos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Image.asset(
            "assets/icon.png",
            height: 110.0,
          ),
        ),
        Column(
          children: const [
            Text(
                "Reportes de daños en la Red Vial Nacional causados por eventos naturales",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                )),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text("Consejo Nacional de Vialidad",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
