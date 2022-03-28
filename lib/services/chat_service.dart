import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/mensajes_response.dart';
import 'auth_service.dart';

class ChatService with ChangeNotifier {
  Usuario? usuarioPara;

  Future<List<Mensaje>>  getChat(String usuarioId) async {
    final resp = await http
        .get(Uri.parse('${Enviroment.apiUrl}/mensajes/$usuarioId'), headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken()
    });
    
    final mensajesResp = mensajesResponseFromJson(resp.body);

    return mensajesResp.mensajes;

  }
}
