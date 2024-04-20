import 'dart:async';
import 'dart:math';

import 'package:flutter_chat/core/models/chat_message.dart';
import 'package:flutter_chat/core/models/chat_user.dart';
import 'package:flutter_chat/core/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [
    ChatMessage(
      id: Random().nextDouble().toString(),
      text: 'Test',
      createdAt: DateTime.now(),
      userId: '1',
      userName: 'teste',
      userImageURL: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: Random().nextDouble().toString(),
      text: 'batata',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'batata',
      userImageURL: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: Random().nextDouble().toString(),
      text: 'abacaxi',
      createdAt: DateTime.now(),
      userId: '456',
      userName: 'abacaxi',
      userImageURL: 'assets/images/avatar.png',
    ),
  ];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    _controller?.add(_msgs);
  });

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _msgsStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final _newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageURL: user.imageURL,
    );

    _msgs.add(
      _newMessage,
    );
    _controller?.add(_msgs.reversed.toList());

    return _newMessage;
  }
}
