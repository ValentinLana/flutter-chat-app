// To parse this JSON data, do
//
//     final usuarioResponse = usuarioResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat_app/models/usuario.dart';


class UsuarioResponse {
    UsuarioResponse({
        required this.ok,
        this.usuarios,
    });

    final bool ok;
    final List<Usuario>? usuarios;

    factory UsuarioResponse.fromRawJson(String str) => UsuarioResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UsuarioResponse.fromJson(Map<String, dynamic> json) => UsuarioResponse(
        ok: json["ok"],
        usuarios: List<Usuario>.from(json["usuarios"].map((x) => Usuario.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuarios": usuarios != null ? List<dynamic>.from(usuarios!.map((x) => x.toJson())) : null
    };
}
