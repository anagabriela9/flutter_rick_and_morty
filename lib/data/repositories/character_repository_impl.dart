import 'package:flutter_rick_and_morty/data/datasources/character_remote_datasource.dart';
import 'package:flutter_rick_and_morty/domain/entities/character.dart';
import 'package:flutter_rick_and_morty/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;

  CharacterRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Character>> getCharacters(String name) async {
    final models = await remoteDataSource.fetchCharacters(name);
    return models.map((model) => model.toEntity()).toList();
  }
}
