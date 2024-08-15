import 'package:flutter_rick_and_morty/domain/entities/character.dart';
import 'package:flutter_rick_and_morty/domain/repositories/character_repository.dart';

class GetCharacters {
  final CharacterRepository repository;

  GetCharacters(this.repository);

  Future<List<Character>> call(String name) async {
    return await repository.getCharacters(name);
  }
}
