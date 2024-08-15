import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_rick_and_morty/domain/entities/character.dart';
import 'package:flutter_rick_and_morty/presentation/cubits/detalle_personaje_cubit.dart';
import 'package:flutter_rick_and_morty/presentation/cubits/detalle_personaje_state.dart';

void main() {
  late DetallePersonajeCubit detallePersonajeCubit;
  late Character character;

  setUp(() {
    character = Character(
      id: 1,
      name: 'Rick Sanchez',
      status: 'Alive',
      species: 'Human',
      gender: 'Male',
      origin: 'Earth',
      location: 'Earth',
      image: '',
    );
    detallePersonajeCubit = DetallePersonajeCubit();
  });

  blocTest<DetallePersonajeCubit, DetallePersonajeState>(
    'emits [DetallePersonajeLoading, DetallePersonajeLoaded] when loadCharacterDetail is called',
    build: () => detallePersonajeCubit,
    act: (cubit) => cubit.loadCharacterDetail(character),
    expect: () => [
      DetallePersonajeLoading(),
      isA<DetallePersonajeLoaded>().having((state) => state.character.name, 'name', 'Rick Sanchez'),
    ],
  );

  blocTest<DetallePersonajeCubit, DetallePersonajeState>(
    'emits [DetallePersonajeLoading, DetallePersonajeError] when loadCharacterDetail fails',
    build: () => detallePersonajeCubit,
    act: (cubit) {
      // Simular un error arrojando una excepción dentro del método
      cubit.loadCharacterDetail(character);
      throw Exception('Error loading character details');
    },
    expect: () => [
      DetallePersonajeLoading(),
      isA<DetallePersonajeError>(),
    ],
  );
}
