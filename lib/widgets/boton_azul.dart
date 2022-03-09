import 'package:flutter/material.dart';

class BtnBlue extends StatelessWidget {
  final void Function() onPressed;
  final String text;

  const BtnBlue({Key? key, required this.onPressed, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          primary: Colors.blue,
          shape: const StadiumBorder(),
        ),
        onPressed: onPressed,
        child: SizedBox(
          width: double.infinity,
          child: Center(
              child: Text(text,
                  style: const TextStyle(color: Colors.white, fontSize: 17))),
        ));
  }
}
