import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

class chatPage extends StatefulWidget {
  const chatPage({super.key});

  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  final _user = const types.User(
    id: 'currentUser',
    role: types.Role.user,
  );
  final _comfyHelper = const types.User(
      id: 'comfyHelper',
    role: types.Role.admin,
  );
  List<types.Message> _messages = [];
  @override
  void initState() {
    final textMessage1 = types.TextMessage(
      author: _comfyHelper,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: 'Hi beautiful',
    );
    _addMessage(textMessage1);
    final textMessage2 = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: 'Thank you',
    );
    _addMessage(textMessage2);
    super.initState();
  }
  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);
    print(_messages.toString());
  }
  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chat(
        messages: _messages,
    onSendPressed: _handleSendPressed,
    user: _user,
      ),
    );
  }
}
