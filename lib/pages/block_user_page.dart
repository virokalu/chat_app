import 'package:app/components/user_tile.dart';
import 'package:app/services/auth/auth_service.dart';
import 'package:app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class BlockUserPage extends StatelessWidget {
  BlockUserPage({super.key});

  //chat and auth service
  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  void _showUnblockBox(BuildContext context, String userId){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Unblock User"),
          content:
          const Text("Are You sure you want to unblock this user"),
          actions: [
            //cancel button
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")),
            //report button
            TextButton(
                onPressed: () {
                  ChatService().unblockUser(userId);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("User Unblocked")));
                },
                child: const Text("UnBlock")),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {

    String userId = authService.getCurrentUser()!.uid;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("B L O C K E D  U S E R S"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: chatService.getBlockedUsers(userId),
        builder: (context, snapshot){
          // error...
          if(snapshot.hasError){
            return const Center(
              child: Text("Error loading..."),
            );
          }

          // loading..
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final blockedUsers = snapshot.data?? [];

          // no Blocked users
          if(blockedUsers.isEmpty) {
            return const Center(
              child: Text("No Blocked Users"),
            );
          }

          return ListView.builder(
              itemCount: blockedUsers.length,
              itemBuilder: (context,index){
            final user = blockedUsers[index];
            return UserTile(text: user["email"],
            onTap: ()=> _showUnblockBox(context, user['uid']),);
          });
        },
      ),
    );
  }
}
