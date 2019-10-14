import 'package:flutter/material.dart';
import 'package:flash_cards/Word.dart';
import 'package:provider/provider.dart';
import 'package:flash_cards/DictionaryModel.dart';

const DROP_ZONE_WIDTH = 80.0;

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

  Widget _renderCard(Word word) {
    return Container(
      padding: const EdgeInsets.only(bottom: DROP_ZONE_WIDTH),
      child: Container(
        width: 200.0,
        height: 200.0,
        child: Card(
          child: Center(
            child: Text(
              word.origin,
              style: Theme.of(context).primaryTextTheme.headline,
            ),
          ),
        ),
      ),
    );
  }

  Widget _default(BuildContext context, List<Word> words) {
    return Stack(children: [
      Row(
        children: <Widget>[
          Expanded(
            child: DragTarget(
              builder: (context, candidateData, rejectedData) {
                return Container();
              },
              onAccept: (data) {
                Provider.of<DictionaryModel>(context, listen: false)
                    .dontKnow(words[_current]);
                setState(() {
                  _current++;
                });
              },
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Expanded(
            child: DragTarget(
              builder: (context, candidateData, rejectedData) {
                return Container();
              },
              onAccept: (data) {
                Provider.of<DictionaryModel>(context, listen: false)
                    .know(words[_current]);
                setState(() {
                  _current++;
                });
              },
            ),
          )
        ],
      ),
      Center(
        child: Draggable(
          child: _renderCard(words[_current]),
          feedback: _renderCard(words[_current]),
          childWhenDragging: _current == words.length - 1
              ? Container(
                  padding: EdgeInsets.only(bottom: DROP_ZONE_WIDTH),
                  child: Container(
                    width: 200,
                    height: 200,
                    child: Card(),
                  ),
                )
              : _renderCard(words[_current + 1]),
        ),
      ),
      Positioned(
        bottom: DROP_ZONE_WIDTH / 2,
        right: 0,
        left: 0,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                color: Colors.redAccent,
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  Provider.of<DictionaryModel>(context, listen: false)
                      .dontKnow(words[_current]);
                  setState(() {
                    _current++;
                  });
                },
              ),
              RaisedButton(
                child: Icon(
                  Icons.done,
                  color: Colors.white,
                ),
                color: Colors.greenAccent,
                onPressed: () {
                  Provider.of<DictionaryModel>(context, listen: false)
                      .know(words[_current]);
                  setState(() {
                    _current++;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget _buildBody(BuildContext context) {
    final List<Word> words =
        Provider.of<DictionaryModel>(context, listen: false).words;
    if (words.length == 0) {
      return _empty();
    }

    return _current == words.length ? _last(context) : _default(context, words);
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
