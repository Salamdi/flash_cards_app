import 'package:flash_cards/EditForm.dart';
import 'package:flutter/material.dart';
import 'package:flash_cards/DictionaryModel.dart';
import 'package:flash_cards/MainScreen.dart';
import 'package:flash_cards/NewWordForm.dart';
import 'package:flash_cards/Train.dart';
import 'package:flash_cards/Word.dart';
import 'package:flash_cards/Tutorial.dart';
import 'package:flash_cards/WordDetails.dart';
import 'package:provider/provider.dart';

class FlashCardsApp extends StatelessWidget {
  final Future<List<Word>> futureWords;

  FlashCardsApp({this.futureWords});

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => DictionaryModel(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.greenAccent,
        ),
        title: 'Flash Cards',
        initialRoute: '/',
        routes: {
          '/': (context) => MainScreen(),
          'add_word': (context) => NewWordForm(),
          'word_details': (context) => WordDetails(),
          'train': (context) => Train(),
          'edit': (context) => EditForm(),
          'tut': (context) => Tutorial(),
        },
      ),
    );
  }
}
