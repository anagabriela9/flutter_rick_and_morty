import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_rick_and_morty/domain/entities/character.dart';
import 'package:flutter_rick_and_morty/presentation/cubits/detalle_personaje_cubit.dart';

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
    expect: () => [DetallePersonajeLoading(), DetallePersonajeLoaded(character)],
  );
}
