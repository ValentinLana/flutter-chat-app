import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  List<ChatMessage> _messages = [];

  bool _estaEscribiendo = false;

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
              child: Text('Te', style: TextStyle(fontSize: 17)),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            SizedBox(height: 3),
            Text('Melissa Flores',
                style: TextStyle(color: Colors.black87, fontSize: 12))
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
          Divider(
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
        margin: EdgeInsets.symmetric(horizontal: 8),
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
                    InputDecoration.collapsed(hintText: 'Enviar mensaje'),
                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: Platform.isIOS
                  ? CupertinoButton(
                      child: Text('Enviar'),
                      onPressed: _estaEscribiendo
                          ? () => _handleSumbit(_textController.text)
                          : null,
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.blue[400]),
                        child: IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: _estaEscribiendo
                                ? () => _handleSumbit(_textController.text)
                                : null,
                            icon: Icon(Icons.send)),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  _handleSumbit(String text) {

    if(text.isEmpty) return;

    _textController.clear();
    _focusNode.requestFocus(); // para que no se baje el teclado

    final newMessage = ChatMessage(
      uid: '123',
      texto: text,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 400)),
    );

    _messages.insert(0, newMessage);

    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    for(ChatMessage message in _messages){
      message.animationController.dispose();
    }
    super.dispose();
  }
}
