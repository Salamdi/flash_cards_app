import 'package:flutter/material.dart';
import 'package:flash_cards/DictionaryModel.dart';
import 'package:flash_cards/Word.dart';
import 'package:provider/provider.dart';

typedef void AddWord(Word word);

class NewWordForm extends StatefulWidget {
  final Word word;

  NewWordForm({this.word});

  @override
  _NewWordFormState createState() => _NewWordFormState();
}

class _NewWordFormState extends State<NewWordForm> {
  final _newWordFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Word _word;

  @override
  void initState() {
    _word = widget.word ?? Word();
    super.initState();
  }

  final FocusNode _wordFocus = FocusNode();
  final FocusNode _translationFocus = FocusNode();
  final FocusNode _sampleFocus = FocusNode();

  _changeFocus(BuildContext context, FocusNode from, FocusNode to) {
    from.unfocus();
    FocusScope.of(context).requestFocus(to);
  }

  _handleSubmit(DictionaryModel dictionary) {
    final form = _newWordFormKey.currentState;
    if (form.validate()) {
      if (_word.id != null) {
        dictionary.update(_word);
      } else {
        dictionary.add(_word);
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(content: Text(_word.id == null ? 'The word has been added' : 'The word has been edited')));
        form.reset();
      }
    }
    _sampleFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DictionaryModel>(
      builder: (context, dictionary, child) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(_word.id == null ? 'Add a New Word' : 'Edit the Word'),
          ),
          body: Form(
            key: _newWordFormKey,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TextFormField(
                    initialValue: _word.origin,
                    onChanged: (value) {
                      setState(() {
                        _word.origin = value;
                      });
                    },
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(labelText: 'Word'),
                    validator: (value) {
                      return value.isEmpty ? 'Required Field' : null;
                    },
                    textInputAction: TextInputAction.next,
                    focusNode: _wordFocus,
                    onFieldSubmitted: (term) {
                      _changeFocus(context, _wordFocus, _translationFocus);
                    },
                  ),
                  TextFormField(
                    initialValue: _word.translation,
                    onChanged: (value) {
                      setState(() {
                        _word.translation = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Word translation'),
                    validator: (value) {
                      return value.isEmpty ? 'Required Field' : null;
                    },
                    textInputAction: TextInputAction.next,
                    focusNode: _translationFocus,
                    onFieldSubmitted: (value) {
                      _changeFocus(context, _translationFocus, _sampleFocus);
                    },
                  ),
                  TextFormField(
                    initialValue: _word.example,
                    onChanged: (value) {
                      setState(() {
                        _word.example = value;
                      });
                    },
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(labelText: 'Sample Sentense'),
                    textInputAction: TextInputAction.done,
                    focusNode: _sampleFocus,
                    onFieldSubmitted: (value) => _handleSubmit(dictionary),
                  ),
                  SafeArea(
                    child: RaisedButton(
                      child: Text(_word.id == null ? 'Add' : 'Edit'),
                      color: Colors.greenAccent,
                      onPressed: () => _handleSubmit(dictionary),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
