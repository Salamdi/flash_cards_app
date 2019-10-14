import 'package:flash_cards/Word.dart';
import 'package:flutter/material.dart';
import 'package:flash_cards/DictionaryModel.dart';
import 'package:provider/provider.dart';

class WordsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DictionaryModel>(
      builder: (context, dictionary, child) {
        final List<Word> words = dictionary.words;
        return ListView.separated(
          itemBuilder: (context, index) => ListTile(
            title: Text(
              words[index].origin,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 24.0),
            ),
            subtitle: Text(
              words[index].example,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 16.0),
            ),
            onTap: () => Navigator.pushNamed(
              context,
              'word_details',
              arguments: words[index],
            ),
          ),
          separatorBuilder: (context, index) => Divider(),
          itemCount: words.length,
        );
      },
    );
  }
}
