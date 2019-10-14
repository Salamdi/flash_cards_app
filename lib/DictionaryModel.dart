import 'package:flutter/cupertino.dart';
import 'package:flash_cards/Word.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String DB_NAME = 'flash_cards_app.db';
const String TABLE_NAME = 'dictionary';

const String CREATE_TABLE = '''
          CREATE TABLE
          $TABLE_NAME(
            id INTEGER PRIMARY KEY,
            origin TEXT,
            translation TEXT,
            example TEXT,
            score INTEGER,
            lastUpdated INTEGER
          )
          ''';

class DictionaryModel extends ChangeNotifier {
  List<Word> _dictionary = [];
  Database database;

  DictionaryModel() {
    _connect()
        .then((void res) => database.query(TABLE_NAME))
        .then((List<Map<String, dynamic>> wordMaps) {
      _dictionary = List
          .generate(
          wordMaps.length, (int index) => Word.fromMap(wordMaps[index]))
        ..sort(_sort);
      notifyListeners();
    });
  }

  Future<void> _connect() async {
    final String dbPath = await getDatabasesPath();
    final String dbFullPath = join(dbPath, DB_NAME);
    database = await openDatabase(
      dbFullPath,
      onCreate: (db, version) {
        return db.execute(CREATE_TABLE);
      },
      version: 1,
    );
  }

  void add(Word word) async {
    final int id = await database.insert(TABLE_NAME, word.toMap());
    word.id = id;
    _dictionary.insert(0, word);
    notifyListeners();
  }

  Future<void> remove(int id) async {
    _dictionary.removeWhere((word) => word.id == id);
    await database.delete(TABLE_NAME, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> know(Word word) async {
    word.increment();
    await update(word);
    _dictionary.sort(_sort);
  }

  Future<void> dontKnow(Word word) async {
    word.decrement();
    await update(word);
    _dictionary.sort(_sort);
  }

  Future<void> update(Word word) async {
    await database.update(
        TABLE_NAME, word.toMap(), where: 'id = ?', whereArgs: [word.id]);
    notifyListeners();
  }

  List<Word> get words {
    final list = _dictionary.sublist(0);
    return list;
  }

  int _sort(Word a, Word b) {
    final scoreSubtraction = a.score - b.score;
    if (scoreSubtraction == 0) {
      return b.id - a.id;
    }
    return scoreSubtraction;
  }
}
