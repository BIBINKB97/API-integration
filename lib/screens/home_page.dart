import 'package:api/model/user_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final UserModel? user;
  const HomePage({super.key, this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi ${widget.user!.username}"),
      ),
      body: Center(
        child: Text('HomePage'),
      ),
    );
  }
}
