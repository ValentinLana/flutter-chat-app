// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

class Usuario {
    Usuario({
        this.online,
        this.id,
        this.nombre,
        this.email,
        this.password,
        this.v,
    });

    final bool? online;
    final String? id;
    final String? nombre;
    final String? email;
    final String? password;
    final int? v;

    factory Usuario.fromRawJson(String str) => Usuario.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        online: json["online"],
        id: json["_id"],
        nombre: json["nombre"],
        email: json["email"],
        password: json["password"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "online": online,
        "_id": id,
        "nombre": nombre,
        "email": email,
        "password": password,
        "__v": v,
    };
}
