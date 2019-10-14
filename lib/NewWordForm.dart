import 'package:flutter/material.dart';
import 'package:flash_cards/DictionaryModel.dart';
import 'package:flash_cards/Word.dart';
import 'package:provider/provider.dart';

typedef void AddWord(Word word);

class NewWordForm extends StatefulWidget {
  @override
  _NewWordFormState createState() => _NewWordFormState();
}

class _NewWordFormState extends State<NewWordForm> {
  final _newWordFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _word = '';
  String _translation = '';
  String _sample = '';

  final FocusNode _wordFocus = FocusNode();
  final FocusNode _translationFocus = FocusNode();
  final FocusNode _sampleFocus = FocusNode();

  _changeFocus(BuildContext context, FocusNode from, FocusNode to) {
    from.unfocus();
    FocusScope.of(context).requestFocus(to);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DictionaryModel>(
      builder: (context, dictionary, child) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('Add a New Word'),
          ),
          body: Form(
            key: _newWordFormKey,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _word = value;
                      });
                    },
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(labelText: 'New Word'),
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
                    onChanged: (value) {
                      setState(() {
                        _translation = value;
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
                    onChanged: (value) {
                      setState(() {
                        _sample = value;
                      });
                    },
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(labelText: 'Sample Sentense'),
                    textInputAction: TextInputAction.done,
                    focusNode: _sampleFocus,
                    onFieldSubmitted: (value) {
                      final form = _newWordFormKey.currentState;
                      if (form.validate()) {
                        dictionary.add(Word(
                            origin: _word,
                            translation: _translation,
                            example: _sample));
                        _scaffoldKey.currentState.showSnackBar(
                            SnackBar(content: Text('Added New Word')));
                        form.reset();
                      }
                      _sampleFocus.unfocus();
                    },
                  ),
                  AddButton(() {
                    dictionary.add(Word(
                        origin: _word,
                        translation: _translation,
                        example: _sample));
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

typedef void EmptyCallback();

class AddButton extends StatelessWidget {
  final EmptyCallback callback;

  AddButton(this.callback);

  void _handleClick(BuildContext context) {
    final form = Form.of(context);
    if (form.validate()) {
      callback();
      form.reset();
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Added New Word')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RaisedButton(
        child: Text('Add'),
        color: Colors.greenAccent,
        onPressed: () => _handleClick(context),
      ),
    );
  }
}
