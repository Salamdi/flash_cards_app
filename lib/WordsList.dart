import 'package:flutter/material.dart';
import 'package:flash_cards/DictionaryModel.dart';
import 'package:provider/provider.dart';

class WordsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DictionaryModel>(
      builder: (context, dictionary, child) {
        return ListView.separated(
          itemBuilder: (context, index) => ListTile(
            title: Text(
              dictionary.words[index].origin,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 24.0),
            ),
            subtitle: Text(
              dictionary.words[index].example,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 16.0),
            ),
            onTap: () => Navigator.pushNamed(
              context,
              'word_details',
              arguments: dictionary.words[index],
            ),
          ),
          separatorBuilder: (context, index) => Divider(),
          itemCount: dictionary.words.length,
        );
      },
    );
  }
}
