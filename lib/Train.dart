import 'package:flutter/material.dart';
import 'package:flash_cards/Word.dart';
import 'package:provider/provider.dart';
import 'package:flash_cards/DictionaryModel.dart';

class Train extends StatefulWidget {

  _TrainState createState() => _TrainState();
}

class _TrainState extends State<Train> {
  int _current = 0;

  Widget _empty() {
    return Center(
      child: Text('There\'s no word to train...'),
    );
  }

  Widget _last(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('go back'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _default(BuildContext context, List<Word> words) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          words[_current].origin,
          style: Theme.of(context).primaryTextTheme.headline,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RaisedButton(
              color: Colors.redAccent,
              child: Icon(Icons.close, color: Colors.white,),
              onPressed: () {
                Provider.of<DictionaryModel>(context, listen: false).dontKnow(words[_current]);
                setState(() {
                  _current++;
                });
              },
            ),
            RaisedButton(
              child: Icon(Icons.done, color: Colors.white,),
              color: Colors.greenAccent,
              onPressed: () {
                Provider.of<DictionaryModel>(context, listen: false).know(words[_current]);
                setState(() {
                  _current++;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    final List<Word> words = Provider.of<DictionaryModel>(context, listen: false).words.take(10).toList();
    if (words.length == 0) {
      return _empty();
    }

    return _current == words.length
        ? _last(context)
        : _default(context, words);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Training'),
      ),
      body: _buildBody(context),
    );
  }
}
