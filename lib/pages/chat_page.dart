import 'dart:io';

import 'package:chat_app/services/socket_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/mensajes_response.dart';
import '../services/auth_service.dart';
import '../services/chat_service.dart';
import '../widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  ChatService? chatService;

  SocketService? socketService;

  AuthService? authService;

  List<ChatMessage> _messages = [];

  bool _estaEscribiendo = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    socketService!.socket!.on('mensaje-personal', (data) => _escucharMensaje);
  
   _cargarHistorial(chatService!.usuarioPara!.id!);

  }

  void _cargarHistorial( String usuarioID ) async {

    List<Mensaje> chat = await chatService!.getChat(usuarioID);

    final history = chat.map((m) => ChatMessage(
      texto: m.mensaje!,
      uid: m.de!,
      animationController: AnimationController(vsync: this, duration: const Duration( milliseconds: 0))..forward(),
    ));

    setState(() {
      _messages.insertAll(0, history);
    });

  }

  void _escucharMensaje(payload) {
    ChatMessage message = ChatMessage(
        texto: payload['mensaje'],
        uid: payload['de'],
        animationController: AnimationController(
            vsync: this, duration: Duration(milliseconds: 300)));

    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text(chatService!.usuarioPara!.nombre!.substring(0, 2),
                  style: const TextStyle(fontSize: 17)),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            const SizedBox(height: 3),
            Text(chatService!.usuarioPara!.nombre!,
                style: const TextStyle(color: Colors.black87, fontSize: 12))
          ],
        ),
      ),
      body: Container(
          child: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemBuilder: (_, i) => _messages[i],
              itemCount: _messages.length,
              physics: const BouncingScrollPhysics(),
              reverse: true,
            ),
          ),
          const Divider(
            height: 1,
          ),
          Container(
            color: Colors.white,
            child: _inputChat(),
          )
        ],
      )),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSumbit,
                onChanged: (String text) {
                  setState(() {
                    if (text.trim().length > 0) {
                      _estaEscribiendo = true;
                    } else {
                      _estaEscribiendo = false;
                    }
                  });
                },
                decoration:
                    const InputDecoration.collapsed(hintText: 'Enviar mensaje'),
                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Platform.isIOS
                  ? CupertinoButton(
                      child: const Text('Enviar'),
                      onPressed: _estaEscribiendo
                          ? () => _handleSumbit(_textController.text)
                          : null,
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.blue[400]),
                        child: IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: _estaEscribiendo
                                ? () => _handleSumbit(_textController.text)
                                : null,
                            icon: const Icon(Icons.send)),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  _handleSumbit(String text) {
    if (text.isEmpty) return;

    _textController.clear();
    _focusNode.requestFocus(); // para que no se baje el teclado

    final newMessage = ChatMessage(
      uid: authService!.usuario!.id!,
      texto: text,
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 400)),
    );

    _messages.insert(0, newMessage);

    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });
    socketService!.emit('mensaje-personal', {
      'de': authService!.usuario!.id,
      'para': chatService!.usuarioPara!.id,
      'mensaje': text
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }

    socketService!.socket!.off('mensaje-personal');

    super.dispose();
  }
}
