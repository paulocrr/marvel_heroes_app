import 'package:marvel_heroes_app/core/networking.dart';
import 'package:marvel_heroes_app/models/character_details.dart';
import 'package:marvel_heroes_app/models/characters_list.dart';

class CharacterService {
  final _basePath = '/v1/public/characters';

  Future<CharactersList> getCharacters({
    int offset = 0,
    int limit = 10,
  }) async {
    final networking = Networking();

    final response = await networking.get(operationPath: _basePath, params: {
      'offset': offset,
      'limit': limit,
    });

    final data = response['data'];

    return CharactersList.fromJson(data);
  }

  Future<CharacterDetails> getCharacterDetails(
      {required int characterId}) async {
    final networking = Networking();

    final response =
        await networking.get(operationPath: '$_basePath/$characterId');
    final data = response['data'];

    return CharacterDetails.fromJson(data);
  }
}
