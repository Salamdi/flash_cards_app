import 'package:flash_cards/NewWordForm.dart';
import 'package:flash_cards/Word.dart';
import 'package:flutter/material.dart';

class EditForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Word word = ModalRoute.of(context).settings.arguments;
    return NewWordForm(word: word);
  }
}
