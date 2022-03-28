import 'package:chat_app/global/environment.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:http/http.dart' as http;

import '../models/usuario.dart';
import '../models/usuarios_response.dart';

class UsuariosService{

  Future<List<Usuario>?> getUsuarios() async {
    try {

      final resp = await http.get(Uri.parse('${Enviroment.apiUrl}/usuarios'),
      headers: {
        'Content-Type' : 'application/json',
        'x-token': await AuthService.getToken()
      });

      final usuarioResponse = UsuarioResponse.fromRawJson(resp.body);

      return usuarioResponse.usuarios;
      
    } catch (e) {
      return [];
    }
  }
}