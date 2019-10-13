import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_cards/DictionaryModel.dart';
import 'package:flash_cards/Word.dart';
import 'package:provider/provider.dart';

class WordDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Word word = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(word.origin),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              word.origin,
              style: Theme.of(context).primaryTextTheme.headline,
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              word.example,
              style: Theme.of(context).primaryTextTheme.title,
            ),
          ),
          Divider(),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                word.translation,
                style: Theme.of(context).primaryTextTheme.title,
              ),
            ),
          ),
          Center(
            child: RaisedButton(
              color: Colors.redAccent,
              child: Text('Delete', style: TextStyle(color: Colors.white),),
              onPressed: () async {
                await Provider.of<DictionaryModel>(context, listen: false).remove(word.id);
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
