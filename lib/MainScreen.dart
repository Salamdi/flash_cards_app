import 'package:flutter/material.dart';
import 'package:flash_cards/WordsList.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Words'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.directions_run),
            tooltip: 'Train',
            onPressed: () => Navigator.pushNamed(context, 'train'),
          ),
          /*IconButton( // TODO: remove
              icon: Icon(Icons.score),
              onPressed: () => Navigator.pushNamed(context, 'tut'),
          )*/
        ],
      ),
      body: WordsList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.black87,),
        backgroundColor: Colors.greenAccent,
        onPressed: () => Navigator.pushNamed(context, 'add_word'),
      ),
    );
  }
}
