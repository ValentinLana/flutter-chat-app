import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mostrarAlerta(BuildContext context, String titulo, String subtitulo) {
  if (Platform.isAndroid) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(subtitulo),
            actions: [
              MaterialButton(
                  child: const Text('Ok'),
                  elevation: 5,
                  textColor: Colors.blue,
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  } else {
    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text(titulo),
            content: Text(subtitulo),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('Ok'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }
}
