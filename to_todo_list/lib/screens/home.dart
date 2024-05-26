import 'package:flutter/material.dart';
import 'package:to_todo_list/constants/colors.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children:[
        Icon(
          Icons.menu,
          color: tdBlack,
          size:30,
          )
        ]),
      ),
      body: Container(
        child: Text('This is the home screen.'),
      ),
    );
  }
}