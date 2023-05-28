import 'package:marvel_heroes_app/models/character.dart';

class CharactersList {
  final int offset;
  final int limit;
  final int total;
  final int count;
  final List<Character> result;

  CharactersList({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.result,
  });

  factory CharactersList.fromJson(Map<String, dynamic> json) {
    return CharactersList(
      offset: json['offset'],
      limit: json['limit'],
      total: json['total'],
      count: json['count'],
      result: List<Character>.from(
        (json['results'] as List<dynamic>).map<Character>(
          (element) => Character.fromJson(element as Map<String, dynamic>),
        ),
      ),
    );
  }
}
