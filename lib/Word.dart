import 'dart:math';

class Word {
  Word({this.origin, this.translation, this.example, this.id})
      : _lastUpdated = DateTime.now(),
        _score = 0;

  Word.fromMap(Map<String, dynamic> json)
    : id = json['id'],
      origin = json['origin'],
      translation = json['translation'],
      example = json['example'],
      _score = json['score'],
      _lastUpdated = DateTime.fromMillisecondsSinceEpoch(json['lastUpdated']);

  int id;
  String origin;
  String translation;
  String example;
  int _score = 0;
  DateTime _lastUpdated;

  void _touch() {
    _lastUpdated = DateTime.now();
  }

  void increment() {
    int newScore = _score + 1;
    _score = max(3, newScore);
    _touch();
  }

  void decrement() {
    int newScore = _score - 1;
    _score = min(0, newScore);
    _touch();
  }

  void update() {
    final int daysPassed = _lastUpdated.difference(DateTime.now()).inDays;
    final int scoresToSubtract = daysPassed ~/ 3;
    final int newScore = min(0, _score - scoresToSubtract);
    if (newScore < _score) {
      _score = newScore;
      _touch();
    }
  }

  Map<String, dynamic> toMap() => {
    'origin': origin,
    'translation': translation,
    'example': example,
    'score': _score,
    'lastUpdated': _lastUpdated.millisecondsSinceEpoch,
  };

  int get score {
    return _score;
  }
}
