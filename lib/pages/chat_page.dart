import 'package:app/services/auth/auth_service.dart';
import 'package:app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverId;
  final String receiverEmail;
  ChatPage({super.key, required this.receiverEmail, required this.receiverId});

  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  ///Send message
  void sendMessage() async {
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(receiverId, _messageController.text);
      //clear controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          //display all the messages

          //user input
        ],
      ),
    );
  }
  Widget _builderMessageList(){
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(stream: _chatService.getMessages(receiverId, senderId), builder: (context,snapshot){

    });
  }
}
