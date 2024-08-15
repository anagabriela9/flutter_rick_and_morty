import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_rick_and_morty/domain/entities/character.dart';
import 'package:flutter_rick_and_morty/domain/usecases/get_characters.dart';
import 'package:flutter_rick_and_morty/presentation/cubits/personajes_cubit.dart';

class MockGetCharacters extends Mock implements GetCharacters {}

void main() {
  late MockGetCharacters mockGetCharacters;
  late PersonajesCubit personajesCubit;

  setUp(() {
    mockGetCharacters = MockGetCharacters();
    personajesCubit = PersonajesCubit(mockGetCharacters);
  });

  blocTest<PersonajesCubit, PersonajesState>(
    'emits [PersonajesLoading, PersonajesLoaded] when fetchCharacters is successful',
    build: () {
      when(() => mockGetCharacters(any())).thenAnswer(
        (_) async => [Character(
          id: 1, 
          name: 'Rick Sanchez', 
          status: 'Alive', 
          species: 'Human', 
          gender: 'Male', 
          origin: 'Earth', 
          location: 'Earth', 
          image: ''
        )],
      );
      return personajesCubit;
    },
    act: (cubit) => cubit.fetchCharacters('Rick'),
    expect: () => [PersonajesLoading(), isA<PersonajesLoaded>()],
  );

  blocTest<PersonajesCubit, PersonajesState>(
    'emits [PersonajesLoading, PersonajesError] when fetchCharacters fails',
    build: () {
      when(() => mockGetCharacters(any())).thenThrow(Exception('Error fetching characters'));
      return personajesCubit;
    },
    act: (cubit) => cubit.fetchCharacters('Rick'),
    expect: () => [PersonajesLoading(), isA<PersonajesError>()],
  );
}
