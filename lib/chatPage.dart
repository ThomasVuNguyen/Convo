import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

class chatPage extends StatefulWidget {
  const chatPage({super.key, required this.questions, required this.answers});
  final Map<String, List<String>> questions; final Map<String, String> answers;

  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  bool _questionAnswered = false;
  Map<String, String> userAnswer = {};
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
    _conversationSequence();
    super.initState();
  }
  
  Future<void> _conversationSequence() async{
    //Loop through the map of conversation
    Map<String, List<String>> questionMap = widget.questions;
    for(var title in questionMap.keys) {
      List<String> questions = questionMap[title]!;
      //Send all questions in the question
      await Future.delayed(Duration(milliseconds: 200));
      for (final question in questions){
        //Send each question one by one
        _sendAdminMessage(question);
        await Future.delayed(Duration(milliseconds: 200));
        print(question);
      }
      //await for response
      while (!_questionAnswered) {
        await Future.delayed(Duration(milliseconds: 100));
      }
      //log response
      userAnswer[title] = _messages.first.toJson()['text'];
      print(userAnswer[title]);
      //ask the next questions
    };
    print(userAnswer.toString());
  }
  
  void _sendAdminMessage(String msg){
    final textMessage = types.TextMessage(
      author: _comfyHelper,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: msg,
    );
    setState(() {
      _messages.insert(0, textMessage);
      _questionAnswered = false;
    });
  }

  void _sendUserMessage(String msg){
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: msg,
    );
    setState(() {
      _messages.insert(0, textMessage);
      _questionAnswered = true;
    });
  }
  void _handleSendPressed(types.PartialText message) {
    _sendUserMessage(message.text);
    //_questionAnswered = true;
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
