import 'package:chat_application/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<void> signOut() async {
    final authService=Provider.of<AuthService>(context,listen: false);

   authService.signOutUser();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:const Text('Welcome your home'),
        actions: [
          IconButton(onPressed: (){}, icon:const Icon(Icons.logout_outlined))
        ],


      ),
    );
  }
}