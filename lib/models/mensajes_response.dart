// To parse this JSON data, do
//
//     final mensajesResponse = mensajesResponseFromJson(jsonString);

import 'dart:convert';

MensajesResponse mensajesResponseFromJson(String str) => MensajesResponse.fromJson(json.decode(str));

String mensajesResponseToJson(MensajesResponse data) => json.encode(data.toJson());

class MensajesResponse {
    MensajesResponse({
        required this.ok,
         this.mensajes,
    });

    bool ok;
    List<Mensaje>? mensajes;

    factory MensajesResponse.fromJson(Map<String, dynamic> json) => MensajesResponse(
        ok: json["ok"],
        mensajes: json["mensajes"] != null ? List<Mensaje>.from(json["mensajes"].map((x) => Mensaje.fromJson(x))) : null,
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "mensajes": mensajes != null ? List<dynamic>.from(mensajes!.map((x) => x.toJson())) : null,
    };
}

class Mensaje {
    Mensaje({
        this.de,
        this.para,
        this.mensaje,
        this.createdAt,
        this.updatedAt,
    });

    String? de;
    String? para;
    String? mensaje;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        de: json["de"],
        para: json["para"],
        mensaje: json["mensaje"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "de": de,
        "para": para,
        "mensaje": mensaje,
        "createdAt": createdAt != null ? createdAt!.toIso8601String() : null,
        "updatedAt": updatedAt != null ? updatedAt!.toIso8601String() : null,
    };
}
