import 'package:dio/dio.dart';
import 'package:flutter_rick_and_morty/data/models/character_model.dart';

class CharacterRemoteDataSource {
  final Dio dio;

  CharacterRemoteDataSource(this.dio);

  Future<List<CharacterModel>> fetchCharacters(String name) async {
    final response = await dio.get('https://rickandmortyapi.com/api/character', queryParameters: {
      'name': name,
    });

    if (response.statusCode == 200) {
      final List results = response.data['results'];
      return results.map((e) => CharacterModel.fromJson(e)).toList();
    } else {
      throw Exception('Error fetching characters');
    }
  }
}
