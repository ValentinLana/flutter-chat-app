import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String text;
  final String textBlue;

  const Labels(
      {Key? key,
      required this.ruta,
      required this.text,
      required this.textBlue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text,
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300)),
        const SizedBox( height: 7,),
        GestureDetector(
          onTap: (() => Navigator.pushReplacementNamed(context, ruta)),
          child: Text(
            textBlue,
            style: TextStyle(
                color: Colors.blue[600],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
