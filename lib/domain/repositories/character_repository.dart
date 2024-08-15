import 'package:flutter_rick_and_morty/domain/entities/character.dart';

abstract class CharacterRepository {
  Future<List<Character>> getCharacters(String name);
}
