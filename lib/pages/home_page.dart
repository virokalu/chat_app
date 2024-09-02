import 'package:app/components/custom_drawer.dart';
import 'package:app/pages/chat_page.dart';
import 'package:app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

import '../components/user_tile.dart';
import '../services/auth/auth_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void logout() {
    //logout here
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("H O M E"),
          actions: [
            ///LogOut
            IconButton(onPressed: logout, icon: const Icon(Icons.logout))
          ],
        ),
        drawer: const CustomDrawer(),
        body: _buildUserList());
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Center(
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Text("E R R O R !"),
              ],
            ),
          );
        }

        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Text("L O A D I N G . . ."),
              ],
            ),
          );
        }

        //list view
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //display user except current user
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        receiverEmail: userData["email"],
                        receiverId: userData['uid'],
                      )));
        },
      );
    } else {
      return Container();
    }
  }
}
